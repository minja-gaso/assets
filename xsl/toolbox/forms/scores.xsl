<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="webformBaseUrl" select="concat(/data/environment/serverName, '/webform/public/')" />
	<xsl:variable name="webformById" select="concat($webformBaseUrl, /data/form/id)" />
	<xsl:variable name="webformPrettyUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
	<xsl:variable name="webformUrlToUse">
		<xsl:value-of select="$webformBaseUrl" />
		<xsl:choose>
			<xsl:when test="string-length(/data/form/prettyUrl) &gt; 0"><xsl:value-of select="/data/form/prettyUrl" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="/data/form/id" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="isSelfAssessment">
		<xsl:choose>
			<xsl:when test="/data/environment/componentId = 2">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:import href="form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<xsl:variable name="webformBaseUrl" select="concat(/data/environment/serverName, 'webforms/self-assessment/')" />
			<xsl:variable name="webformUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
			<div class="row">
				<div class="col-lg-12">
					<nav>
						<xsl:variable name="QUESTION_ACTION">
								<xsl:choose>
									<xsl:when test="/data/environment/componentId = 1">QUESTION_LIST</xsl:when>
									<xsl:otherwise>QUESTIONS_AND_ANSWERS</xsl:otherwise>
								</xsl:choose>
						</xsl:variable>
						<xsl:call-template name="primary_navigation">
							<xsl:with-param name="SCREEN" select="'SCORES'" />
						</xsl:call-template>
					</nav>
					<h2>Self-Assessment Scores</h2>
					<div class="form-row">
						<div class="row">
							<xsl:variable name="minScore" select="count(/data/form/question) * number(/data/possibleAnswer[position() = 1]/value)" />
							<xsl:variable name="maxScore" select="count(/data/form/question) * number(/data/possibleAnswer[position() = last()]/value)" />
							<div class="col-lg-2">
								<label for="SCORE_BEGIN">Low Score (min: <xsl:value-of select="$minScore" />)</label>
								<input type="text" class="form-control" name="ADD_SCORE_BEGIN" />
								<hr />
								<label for="SCORE_END">High Score (max: <xsl:value-of select="$maxScore" />)</label>
								<input type="text" class="form-control" name="ADD_SCORE_END" />
							</div>
							<div class="col-lg-10">
								<textarea class="tinymce" id="ADD_SCORE_SUMMARY" name="ADD_SCORE_SUMMARY">
									<xsl:text>&#x0A;</xsl:text>
								</textarea>
							</div>
						</div>
					</div>
					<hr/>
					<table class="table table-condensed">
						<caption>Available Scores</caption>
						<thead>
							<tr>
								<th class="col-lg-2 text-center">Score Range</th>
								<th class="col-lg-8">Label</th>
								<th class="col-lg-1 text-center">Edit</th>
								<th class="col-lg-1 text-center">Delete</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="/data/form/question">
								<tr>
									<th colspan="4">Item.</th>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
					<!--
					<div class="form-group">
						<textarea class="tinymce">
							<xsl:text>&#x0A;</xsl:text>
						</textarea>
					</div>
					-->
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
