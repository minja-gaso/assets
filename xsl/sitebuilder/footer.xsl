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
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/preview/', id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="FOOTER" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'FOOTER'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Append Styles</h2>
				<p class="help-block">These styles will override those in stylesheets.</p>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:saveWebsite();">Save</a>
					<a class="btn btn-danger" href="javascript:websiteList();">Back to Websites</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="WEBSITE_FOOTER">Styles</label>
				<textarea class="form-control" name="WEBSITE_FOOTER" id="WEBSITE_FOOTER" rows="20">
					<xsl:choose>
						<xsl:when test="string-length(footer) &gt; 0">
							<xsl:value-of select="footer" />
						</xsl:when>
						<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
					</xsl:choose>
				</textarea>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
