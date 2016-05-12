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
	<xsl:template match="website">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/page/', page/id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="COMPONENT_ITEM" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="PAGE_ID" value="{/data/website/page/id}" />
			<input type="hidden" name="COMPONENT_ID" value="{/data/website/page/component/id}" />
			<input type="hidden" name="COMPONENT_ITEM_ID" value="{/data/website/page/component/item/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="component_item_edit" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Page</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:saveComponentItem();">Save</a>
					<a class="btn btn-danger" href="javascript:switchTab('COMPONENT');">Back to Pages</a>
					<a class="btn btn-primary" href="{$url}" target="_blank">View Page</a>
				</div>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="main">
		<xsl:variable name="selectedTemplateId" select="page/fkTemplateId" />
		<xsl:variable name="vanityUrl" select="concat(/data/website/url, '/', page/url)" />
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="COMPONENT_ITEM_TITLE">Title</label>
				<p class="help-block"><small>If <em>tab component</em>, this will be the label for the tab.</small></p>
				<input type="text" class="form-control" name="COMPONENT_ITEM_TITLE" id="COMPONENT_ITEM_TITLE" value="{page/component/item/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="COMPONENT_ITEM_HTML" class="show">Content</label>
				<textarea class="form-control" name="COMPONENT_ITEM_HTML" id="COMPONENT_ITEM_HTML" rows="20">
					<xsl:choose>
						<xsl:when test="string-length(page/component/item/html) &gt; 0">
							<xsl:value-of select="page/component/item/html" />
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
