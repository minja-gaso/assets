<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/question_variables.xsl" />
	<xsl:include href="includes/question_nav.xsl" />
	<xsl:include href="includes/question_templates.xsl" />

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
			<input type="hidden" name="SCREEN" value="{$screen}" />
			<input type="hidden" name="QUESTION_TYPE" value="{$questionType}" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="QUESTION_ID" value="{/data/form/question/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="multiple_choice_nav" />
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Edit Question <small class="hidden"><xsl:value-of select="/data/form/question/type" /></small></h2>
					<xsl:call-template name="messages" />
					<xsl:call-template name="main" />
					<div class="btn-toolbar">
						<a class="btn btn-success" href="javascript:saveQuestion();submitForm();">Save</a>
						<a class="btn btn-danger" href="javascript:switchTab('QUESTION_LIST');submitForm();">Back to Questions</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:apply-templates select="question" />
		<xsl:call-template name="answers" />
	</xsl:template>
</xsl:stylesheet>
