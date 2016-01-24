<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">	
	<xsl:variable name="isSelfAssessment">
		<xsl:choose>
			<xsl:when test="/data/environment/componentId = 2">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="webformBaseUrl">
		<xsl:choose>
			<xsl:when test="$isSelfAssessment = 'true'">
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/self-assessment/')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/public/')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="webformById" select="concat($webformBaseUrl, /data/form/id)" />
	<xsl:variable name="webformPrettyUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
	<xsl:variable name="webformUrlToUse">
		<xsl:value-of select="$webformBaseUrl" />
		<xsl:choose>
			<xsl:when test="string-length(/data/form/prettyUrl) &gt; 0"><xsl:value-of select="/data/form/prettyUrl" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="/data/form/id" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:import href="form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="EDIT_SCORE" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="SCORE_ID" value="{/data/score/id}" />
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
						<xsl:call-template name="score_nav" />
					</nav>
					<h2>Self-Assessment Scores</h2>
					<xsl:if test="count(/data/message) &gt; 0">
						<xsl:for-each select="/data/message">
							<xsl:variable name="type">
								<xsl:choose>
									<xsl:when test="type='error'">danger</xsl:when>
									<xsl:when test="type='success'">success</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<div class="alert alert-{$type}"><xsl:value-of select="label" /></div>
						</xsl:for-each>
					</xsl:if>
					<div class="form-row">
						<div class="row">
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
							<div class="col-md-12">
								<label for="SCORE_SUMMARY">Summary</label>
								<input id="SCORE_SUMMARY" type="hidden" name="SCORE_SUMMARY" value="{/data/score/summary}"/>
  							<trix-editor input="SCORE_SUMMARY"></trix-editor>
								<!--
								<textarea class="tinymce" id="SCORE_SUMMARY" name="SCORE_SUMMARY">
									<xsl:choose>
										<xsl:when test="string-length(/data/score/summary) &gt; 0">
											<xsl:value-of select="/data/score/summary" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>&#x0A;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</textarea>
							-->
							</div>
						</div>
					</div>
					<hr />
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveScore();">Save</a>
						<a class="btn btn-default" href="javascript:formScores();">Back to Scores</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
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
