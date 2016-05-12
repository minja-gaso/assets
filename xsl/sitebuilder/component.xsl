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
			<input type="hidden" name="SCREEN" value="COMPONENT" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="PAGE_ID" value="{/data/website/page/id}" />
			<input type="hidden" name="COMPONENT_ID" value="{/data/website/page/component/id}" />
			<input type="hidden" name="COMPONENT_ITEM_ID" />
			<input type="hidden" name="COMPONENT_ITEM_ORDER_NUMBER" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="component_edit" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Component</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:saveComponent();">Save</a>
					<a class="btn btn-danger" href="javascript:switchTab('PAGE');">Back to Pages</a>
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
				<label for="COMPONENT_TITLE">Title</label>
				<input type="text" class="form-control" name="COMPONENT_TITLE" id="COMPONENT_TITLE" value="{page/component/title}" />
			</div>
		</div>
		<xsl:call-template name="component_type">
			<xsl:with-param name="type" select="/data/website/page/component/type" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="component_type">
		<xsl:param name="type" />
		<xsl:if test="($type = 'standard' and count(page/component/item) = 0) or $type = 'tab' or $type = 'anchor'">
			<div class="row">
				<div class="form-group col-sm-12">
					<a class="btn btn-primary" href="javascript:createComponentItem();">Add New Item</a>
				</div>
			</div>
		</xsl:if>

		<xsl:if test="count(page/component/item) &gt; 0">
			<table class="table table-condensed">
				<thead>
					<tr>
						<th class="col-sm-1 text-center">Number</th>
						<th class="col-sm-1 text-center">ID</th>
						<th class="col-sm-1 text-center">Delete</th>
						<th>Title</th>
						<th class="col-sm-1 text-center">Order</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="page/component/item">
						<tr>
							<th class="text-center"><xsl:value-of select="orderNumber" /></th>
							<td class="text-center"><a href="javascript:editComponentItem('{id}')"><span class="fa fa-edit" /></a></td>
							<td class="text-center"><a href="javascript:deleteComponentItem('{id}')"><span class="fa fa-trash" /></a></td>
							<td><xsl:value-of select="title" /></td>
							<td>
								<div class="reorder">
									<xsl:if test="position() > 1">
										<span class="" style="float:left;">
											<a href="javascript:moveComponentItem('{orderNumber - 1}', '{id}');"><span class="fa fa-arrow-up"></span></a>
										</span>
									</xsl:if>
									<xsl:if test="position() != last()">
										<span class="" style="float:right;">
											<a href="javascript:moveComponentItem('{orderNumber + 1}', '{id}');"><span class="fa fa-arrow-down"></span></a>
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
</xsl:stylesheet>
