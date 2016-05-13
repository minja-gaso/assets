<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output type="html" />
	<xsl:template match="/">
		<style type="text/css">
			ccccccc#elements { margin: 0 auto; max-width: 800px; border: 1px solid #ccc; padding: 24px; }
		</style>
		<div class="row">
			<ul class="nav nav-pills pull-right sticky-tabs">
				<xsl:for-each select="/data/website/page/component">
					<li><a href="#element-{id}"><xsl:value-of select="title" /></a></li>
				</xsl:for-each>
			</ul>
		</div>
		<div id="elements">
			<xsl:for-each select="/data/website/page">
				<xsl:for-each select="component">
					<xsl:if test="count(item) &gt; 0">
						<xsl:choose>
							<xsl:when test="type = 'standard'">
								<xsl:call-template name="standard" />
							</xsl:when>
							<xsl:when test="type = 'tab'">
								<xsl:call-template name="tab" />
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<!--
					<h4>Component: <xsl:value-of select="title" /></h4>
					<xsl:if test="count(item) &gt; 0">
						<ul>
							<xsl:for-each select="item">
								<li><xsl:value-of select="title" /></li>
							</xsl:for-each>
						</ul>
					</xsl:if>
				-->
				</xsl:for-each>
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="standard">
		<div id="element-{id}">
			<xsl:for-each select="item">
				<h2><xsl:value-of select="title" /></h2>
				<xsl:value-of select="html" disable-output-escaping="yes" />
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="tab">
		<div id="element-{id}" class="tabbed">
			<h2><xsl:value-of select="title" /></h2>
			<ul class="nav nav-tabs nav-justified" role="tablist">
				<xsl:for-each select="item">
					<li role="presentation">
						<xsl:if test="position() = 1">
							<xsl:attribute name="class">active</xsl:attribute>
						</xsl:if>
						<a href="#tab-{id}" aria-controls="tab-{id}" role="tab" data-toggle="tab">
							<xsl:value-of select="title" />
						</a>
					</li>
				</xsl:for-each>
			</ul>
			<div class="tab-content">
				<xsl:for-each select="item">
					<div role="tabpanel" class="tab-pane" id="tab-{id}">
						<xsl:if test="position() = 1">
							<xsl:attribute name="class">tab-pane active</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="html" disable-output-escaping="yes" />
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
