<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="website" />
	</xsl:template>
	<xsl:template match="admin"></xsl:template>
	<xsl:template match="website">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/page/', page/id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="PAGE" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="PAGE_ID" value="{/data/website/page/id}" />
			<input type="hidden" name="COMPONENT_ID" />
			<input type="hidden" name="COMPONENT_TYPE" />
			<input type="hidden" name="COMPONENT_ORDER_NUMBER" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="page_edit">
					<xsl:with-param name="SCREEN" select="'PAGE'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Page</h2>
				<xsl:call-template name="messages" />
				<!--
					<xsl:choose>
						<xsl:when test="/data/admin = 'true'">
							<xsl:call-template name="main_alt" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="main" />
						</xsl:otherwise>
					</xsl:choose>
				-->
				<xsl:call-template name="main_alt" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:saveWebsitePage();">Save</a>
					<a class="btn btn-danger" href="javascript:switchTab('PAGES');">Back to Pages</a>
					<a class="btn btn-primary" href="{$url}" target="_blank">View Page</a>
				</div>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="main_alt">
		<xsl:variable name="selectedTemplateId" select="page/fkTemplateId" />
		<div class="row">
			<div class="form-group col-xs-12">
				<label for="PAGE_TITLE">Title</label>
				<input type="text" class="form-control" name="PAGE_TITLE" id="PAGE_TITLE" value="{page/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_TEMPLATE">Template</label>
				<select class="form-control" name="PAGE_TEMPLATE" id="PAGE_TEMPLATE" onchange="saveWebsitePage();">
					<option value="0" />
					<xsl:for-each select="template">
						<option value="{id}">
							<xsl:if test="id = $selectedTemplateId">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="title" />
						</option>
					</xsl:for-each>
				</select>
			</div>
		</div>
		<!--
		<a class="btn btn-primary" href="javascript:createComponent('CREATE_COMPONENT', 'tab');">Insert Tabbed Content</a>
	-->
		<div class="form-group">
			<label for="NEW_COMPONENT">New Component Type</label>
			<select class="form-control" name="NEW_COMPONENT" onchange="createComponent('CREATE_COMPONENT', this.value);">
				<option selected="selected" disabled="disabled" value="" />
				<option value="heading">Heading</option>
				<option value="text">Text</option>
				<option value="column">Multi-Column</option>
				<!--
					<option value="anchor">Anchor</option>
				-->
				<option value="tab">Tabbed</option>
			</select>
		</div>
		<xsl:if test="count(page/component) &gt; 0">
			<table class="table table-bordered">
				<caption class="text-center">Components Within Page</caption>
				<thead>
					<tr>
						<!--
							<th>ID</th>
						-->
						<th class="col-sm-1 text-center">Order</th>
						<th class="col-sm-1 text-center">Type</th>
						<th>Title</th>
						<th class="col-sm-1 text-center">Delete</th>
						<th class="col-sm-1 text-center">Order</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="page/component">
						<tr>
							<!--
								<th><a href="javascript:editComponent('{id}');"><xsl:value-of select="id" /></a></th>
							-->
							<td class="text-center"><xsl:value-of select="orderNumber" /></td>
							<td class="text-center">
								<xsl:choose>
									<xsl:when test="type != 'heading'">
										<xsl:value-of select="type" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="typeValue" />
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<a href="javascript:editComponent('{id}');">
									<xsl:choose>
										<xsl:when test="string-length(title) &gt; 0">
											<xsl:value-of select="title" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class">text-danger</xsl:attribute>
											<xsl:text>Please provide a title to this component</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</a>
							</td>
							<td class="text-center"><a href="javascript:deleteComponent('{id}');"><span class="fa fa-trash"></span></a></td>
							<td>
								<div class="reorder">
									<xsl:if test="position() > 1">
										<span class="" style="float:left;">
											<a href="javascript:moveComponent('{orderNumber - 1}', '{id}');"><span class="fa fa-arrow-up"></span></a>
										</span>
									</xsl:if>
									<xsl:if test="position() != last()">
										<span class="" style="float:right;">
											<a href="javascript:moveComponent('{orderNumber + 1}', '{id}');"><span class="fa fa-arrow-down"></span></a>
										</span>
									</xsl:if>
								</div>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<xsl:variable name="selectedTemplateId" select="page/fkTemplateId" />
		<xsl:variable name="vanityUrl" select="concat(/data/website/url, '/', page/url)" />
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="PAGE_TITLE">Title</label>
				<input type="text" class="form-control" name="PAGE_TITLE" id="PAGE_TITLE" value="{page/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_SUBTITLE">Subtitle</label>
				<input type="text" class="form-control" name="PAGE_SUBTITLE" id="PAGE_SUBTITLE" value="{page/subtitle}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_URL">Vanity URL</label>
				<input type="text" class="form-control" name="PAGE_URL" id="PAGE_URL" value="{page/url}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_TEMPLATE">Template</label>
				<select class="form-control" name="PAGE_TEMPLATE" id="PAGE_TEMPLATE" onchange="saveWebsitePage();">
					<option value="0" />
					<xsl:for-each select="template">
						<option value="{id}">
							<xsl:if test="id = $selectedTemplateId">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="title" />
						</option>
					</xsl:for-each>
				</select>
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_HTML" class="show">HTML</label>
				<textarea class="form-control" name="PAGE_HTML" id="PAGE_HTML" rows="20">
					<xsl:if test="/data/skin/editable = 'false'">
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="string-length(page/html) &gt; 0">
							<xsl:value-of select="page/html" />
						</xsl:when>
						<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
					</xsl:choose>
				</textarea>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.3.10/tinymce.min.js">//</script>
				<script>
					tinymce.init({
					  selector: 'textarea',
					  height: 500,
					  theme: 'modern',
					  plugins: [
					    'advlist autolink lists link image charmap print preview hr anchor pagebreak',
					    'searchreplace wordcount visualblocks visualchars code fullscreen',
					    'insertdatetime media nonbreaking save table contextmenu directionality',
					    'emoticons template paste textcolor colorpicker textpattern imagetools'
					  ],
					  toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
					  toolbar2: 'print preview media | forecolor backcolor emoticons',
					  image_advtab: true
				  });
					</script>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
