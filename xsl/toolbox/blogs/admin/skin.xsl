<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/blog_variables.xsl" />
	<xsl:include href="../includes/blog_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="SKIN" />
			<input type="hidden" name="BLOG_ID" value="{/data/blog/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'SKIN'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<a class="btn btn-default" href="javascript:saveBlog();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Blogs</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Blog</a>
				</div>
				<h2>Appearance</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default" href="javascript:saveBlog();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Blogs</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Blog</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="skin-select">
			<div class="form-group col-xs-12">
				<label for="BLOG_SKIN_ID">Choose a Skin</label>
				<div class="styled-select">
					<select class="form-control" name="BLOG_SKIN_ID" id="BLOG_SKIN_ID" onchange="saveBlog();submitForm();">
						<option />
						<xsl:apply-templates select="skin" />
					</select>
				</div>
			</div>
		</div>
		<hr />
		<div class="row" id="skin-preview">
			<div class="form-group col-xs-12">
				<label for="BLOG_PREVIEW">Preview</label>
				<div class="embed-responsive embed-responsive-16by9">
				  <iframe class="embed-responsive-item" src="{$listUrl}">//</iframe>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="skin">
		<option value="{id}">
			<xsl:if test="/data/blog/fkSkinId = id">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:text><xsl:value-of select="title" /></xsl:text>
		</option>
	</xsl:template>
</xsl:stylesheet>
