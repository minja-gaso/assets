<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="APPEARANCE" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'APPEARANCE'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
          <a class="btn btn-default" href="javascript:document.portal_form.ACTION.value='SAVE_FORM';submitForm();">Save</a>
          <a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
          <a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
				</div>
				<h2>Appearance</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
        <div class="btn-toolbar">
          <a class="btn btn-default" href="javascript:document.portal_form.ACTION.value='SAVE_FORM';submitForm();">Save</a>
          <a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
          <a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
        </div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="skin-select">
			<div class="form-group col-xs-12">
				<label for="FORM_SKIN_ID">Choose a Skin</label>
				<div class="styled-select">
					<select class="form-control" name="FORM_SKIN_ID" id="FORM_SKIN_ID" onchange="document.portal_form.ACTION.value='SAVE_FORM';submitForm();">
						<option value="0" />
						<xsl:apply-templates select="skin" />
					</select>
				</div>
			</div>
		</div>
		<hr />
		<div class="row" id="skin-preview">
			<div class="form-group col-xs-12">
				<label for="CALENDAR_PREVIEW">Preview</label>
				<div class="embed-responsive embed-responsive-16by9">
				  <iframe class="embed-responsive-item" src="{$webformUrlToUse}">//</iframe>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template match="skin">
		<option value="{id}">
			<xsl:if test="/data/form/fkSkinId = id">
				<xsl:attribute name="selected">selected</xsl:attribute>
			</xsl:if>
			<xsl:text><xsl:value-of select="title" /></xsl:text>
		</option>
	</xsl:template>
</xsl:stylesheet>
