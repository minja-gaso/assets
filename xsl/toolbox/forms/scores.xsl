<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>	
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
			<input type="hidden" name="SCREEN" value="SCORES" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="SCORE_ID" />
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
					<a class="btn btn-primary pull-right" href="javascript:createScore();">New Score Range</a>
					<table class="table table-condensed">
						<caption>Available Scores</caption>
						<thead>
							<tr>
								<th class="col-lg-1 col-sm-2 text-center">Score Range</th>
								<th class="col-lg-9 col-sm-8">Label</th>
								<th class="col-lg-1 col-sm-1 text-center">Edit</th>
								<th class="col-lg-1 col-sm-1 text-center">Delete</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="/data/score">
								<tr>
									<td class="text-center"><xsl:value-of select="begin" />&#160;-&#160;<xsl:value-of select="end" /></td>
									<td><xsl:value-of select="title" /></td>
									<td class="text-center"><a href="javascript:editScore('{id}');"><span class="fa fa-pencil fa-lg" /></a></td>
									<td class="text-center"><a href="javascript:deleteScore('{id}');"><span class="fa fa-trash fa-lg" /></a></td>
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
