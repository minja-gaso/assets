<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="form" />
	</xsl:template>
	<xsl:template match="form">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'REPORTS'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
				<h2>Generate Reports</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
					<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="form-group">
			<label for="PDF_GENERATE">Create PDF</label>
			<p><a class="btn btn-primary" href="survey/pdf/summary/{/data/form/id}" target="_blank">Summary</a></p>
		</div>
		<div class="form-group">
			<label for="CSV_GENERATE">Create Excel CSV</label>
			<p><a class="btn btn-primary" href="survey/csv/summary/{/data/form/id}" target="_blank">Summary</a></p>
		</div>
	</xsl:template>
</xsl:stylesheet>
