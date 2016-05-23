<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output type="html" />
	<xsl:template match="/">
		<div class="row">
			<ul class="nav nav-pills pull-right sticky-tabs">
				<xsl:for-each select="/data/website/page/component[type != 'heading']">
					<li><a href="#element-{id}"><xsl:value-of select="title" /></a></li>
				</xsl:for-each>
			</ul>
		</div>
		<div id="elements">
			<xsl:for-each select="/data/website/page/component">
				<xsl:choose>
					<xsl:when test="type = 'heading'">
						<xsl:call-template name="heading" />
					</xsl:when>
					<xsl:when test="type = 'text'">
						<xsl:call-template name="standard" />
					</xsl:when>
					<xsl:when test="type = 'column'">
						<xsl:call-template name="column" />
					</xsl:when>
					<xsl:when test="type = 'tab'">
						<xsl:if test="count(item) &gt; 0">
							<xsl:call-template name="tab" />
						</xsl:if>
					</xsl:when>
				</xsl:choose>
				<!--
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
		</div>
	</xsl:template>
	<xsl:template name="heading">
		<xsl:choose>
			<xsl:when test="typeValue = 'h1'">
				<h1 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h1>
			</xsl:when>
			<xsl:when test="typeValue = 'h2'">
				<h2 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h2>
			</xsl:when>
			<xsl:when test="typeValue = 'h3'">
				<h3 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h3>
			</xsl:when>
			<xsl:when test="typeValue = 'h4'">
				<h4 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h4>
			</xsl:when>
			<xsl:when test="typeValue = 'h5'">
				<h5 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h5>
			</xsl:when>
			<xsl:when test="typeValue = 'h6'">
				<h6 class="row {style}" id="element-{id}">
					<xsl:value-of select="value" />
				</h6>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="standard">
		<div id="element-{id}" class="row {style}">
			<xsl:value-of select="value" disable-output-escaping="yes" />
		</div>
	</xsl:template>
	<xsl:template name="column">
		<div id="element-{id}" class="row">
			<xsl:for-each select="item">
				<div class="{../style}">
					<xsl:value-of select="html" disable-output-escaping="yes" />
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="tab">
		<div id="element-{id}" class="row tabbed {style}">
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
			<script>
				$(document).ready(function(){
					$("#element-<xsl:value-of select="id" />").tab();
				})
			</script>
		</div>
	</xsl:template>
</xsl:stylesheet>
