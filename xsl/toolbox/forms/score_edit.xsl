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
			<input type="hidden" name="SCREEN" value="EDIT_SCORE" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="SCORE_ID" value="{/data/score/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="score_nav" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveScore();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formScores();submitForm();">Back to Scores</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
				<h2>Self-Assessment Scores</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default" href="javascript:saveScore();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:formScores();submitForm();">Back to Scores</a>
					<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="form-group">
			<xsl:variable name="possibleAnswerMinValue">
				<xsl:choose>
					<xsl:when test="count(/data/possibleAnswer) = 0">0</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="number(/data/possibleAnswer[position() = 1]/value)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
				<xsl:variable name="possibleAnswerMaxValue">
					<xsl:choose>
						<xsl:when test="count(/data/possibleAnswer) = 0">0</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="number(/data/possibleAnswer[position() = last()]/value)" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
			<xsl:variable name="minScore" select="count(/data/form/question) * $possibleAnswerMinValue" />
			<xsl:variable name="maxScore" select="count(/data/form/question) * $possibleAnswerMaxValue" />
			<div class="row">
				<div class="col-lg-6 col-md-8">
					<label for="SCORE_TITLE">Label</label>
					<input type="text" class="form-control" id="SCORE_TITLE" name="SCORE_TITLE" value="{/data/score/title}" />
				</div>
				<div class="col-lg-3 col-md-2">
					<label for="SCORE_BEGIN">Low Score (min: <xsl:value-of select="$minScore" />)</label>
					<select class="form-control" id="SCORE_BEGIN" name="SCORE_BEGIN">
						<xsl:call-template name="numeric_select">
							<xsl:with-param name="startIndex" select="$minScore" />
							<xsl:with-param name="currentIndex" select="$minScore" />
							<xsl:with-param name="selectedIndex" select="/data/score/begin" />
							<xsl:with-param name="endIndex" select="$maxScore" />
						</xsl:call-template>
					</select>
				</div>
				<div class="col-lg-3 col-md-2">
					<label for="SCORE_END">High Score (max: <xsl:value-of select="$maxScore" />)</label>
					<select class="form-control" id="SCORE_END" name="SCORE_END">
						<xsl:call-template name="numeric_select">
							<xsl:with-param name="startIndex" select="$minScore" />
							<xsl:with-param name="currentIndex" select="$minScore" />
							<xsl:with-param name="selectedIndex" select="/data/score/end" />
							<xsl:with-param name="endIndex" select="$maxScore" />
						</xsl:call-template>
					</select>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="SCORE_SUMMARY">Summary</label>
			<input id="SCORE_SUMMARY" type="hidden" name="SCORE_SUMMARY" value="{/data/score/summary}"/>
			<trix-editor input="SCORE_SUMMARY"></trix-editor>
		</div>
	</xsl:template>
	<xsl:template name="numeric_select">
		<xsl:param name="startIndex" />
		<xsl:param name="currentIndex" />
		<xsl:param name="selectedIndex" />
		<xsl:param name="endIndex" />

		<xsl:if test="$currentIndex &lt;= $endIndex">
			<option value="{$currentIndex}">
				<xsl:if test="$currentIndex = $selectedIndex">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$currentIndex" />
			</option>
			<xsl:call-template name="numeric_select">
				<xsl:with-param name="startIndex" select="$startIndex" />
				<xsl:with-param name="currentIndex" select="$currentIndex + 1" />
				<xsl:with-param name="selectedIndex" select="$selectedIndex" />
				<xsl:with-param name="endIndex" select="$endIndex" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
