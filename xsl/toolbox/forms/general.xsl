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
	<xsl:include href="form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<div class="row">
				<div class="col-lg-12 bordered-area">
					<nav>
						<xsl:variable name="QUESTION_ACTION">
								<xsl:choose>
									<xsl:when test="/data/environment/componentId = 1">QUESTION_LIST</xsl:when>
									<xsl:otherwise>QUESTIONS_AND_ANSWERS</xsl:otherwise>
								</xsl:choose>
						</xsl:variable>
						<xsl:call-template name="primary_navigation">
							<xsl:with-param name="SCREEN" select="'GENERAL'" />
						</xsl:call-template>
					</nav>
					<h2>General Information</h2>
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
					<div class="form-group">
						<label for="FORM_TITLE">Title</label>
						<input type="text" class="form-control" name="FORM_TITLE" id="FORM_TITLE" value="{/data/form/title}" />
					</div>
					<div class="form-group">
						<label class="radio-inline">
						  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_DRAFT" value="draft">
								<xsl:if test="/data/form/status = 'draft'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input> Draft
						</label>
							<label class="radio-inline">
							  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_LIVE" value="live">
									<xsl:if test="/data/form/status = 'live'">
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>
								</input> Live
							</label>
						<label class="radio-inline">
						  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_ENDED" value="ended">
								<xsl:if test="/data/form/status = 'ended'">
									<xsl:attribute name="checked">checked</xsl:attribute>
								</xsl:if>
							</input> Ended
						</label>
					</div>
					<div class="form-group">
						<label for="FORM_URL">Standard URL</label>
						<p class="help-block">If you do not care about SEO, feel free to link to this URL.</p>
						<div class="input-group">
							<span class="input-group-addon"><xsl:value-of select="$webformBaseUrl" /></span>
							<input type="text" class="form-control" name="FORM_URL" id="FORM_URL" value="{/data/form/id}" />
							<input type="hidden" name="HIDDEN_FORM_URL" id="HIDDEN_FORM_URL" value="{$webformById}" />
							<a href="{concat($webformBaseUrl, /data/form/id)}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
						</div>
					</div>
					<div class="form-group">
						<label for="FORM_PRETTY_URL">Pretty URL</label>
						<p class="help-block">We recommend a <em>Pretty URL</em>. You may use alphanumeric characters, hyphens, underscores and periods. This will be better for SEO.</p>
						<div class="input-group">
							<span class="input-group-addon"><xsl:value-of select="$webformBaseUrl" /></span>
							<input type="text" class="form-control" name="FORM_PRETTY_URL" id="FORM_PRETTY_URL" value="{/data/form/prettyUrl}" />
							<a href="{$webformPrettyUrl}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-lg-6">
							<label for="FORM_SKIN_URL">Skin URL</label>
							<p class="help-block">If you wish to have a skin around the survey, enter a URL.</p>
							<input type="text" class="form-control" name="FORM_SKIN_URL" id="FORM_SKIN_URL" value="{/data/form/skinUrl}" />
						</div>
						<div class="form-group col-lg-6">
							<label for="FORM_SKIN_SELECTOR">Skin CSS Selector</label>
							<p class="help-block">Element ID or class in which to insert content.</p>
							<input type="text" class="form-control" name="FORM_SKIN_SELECTOR" id="FORM_SKIN_SELECTOR" value="{/data/form/skinSelector}" />
						</div>
					</div>
					<div class="row">
						<div class="col-lg-3">
							<label for="FORM_START_DATE">Start Date</label>
							<input type="text" class="form-control datepicker" name="FORM_START_DATE" id="FORM_START_DATE" />
						</div>
						<script>
							$(document).ready(function(){
								$("#FORM_START_DATE").datepicker();
							});
						</script>
					</div>
					<div class="row">
						<p class="col-lg-12">
							<strong>Submissions</strong>
							<small class="help-block">
								If <strong>Max Submissions (while being set > 0)</strong> is less than or equal to <strong>Total Submissions</strong>, users receive a "max submissions limit reached" message.
								This message can be customized on the <span class="text-danger">Messages</span> tab.
							</small>
						</p>
						<div class="form-group col-lg-1">
							<label for="FORM_TOTAL_SUBMISSIONS">Total</label>
							<input type="text" class="form-control" name="FORM_TOTAL_SUBMISSIONS" id="FORM_TOTAL_SUBMISSIONS" value="{/data/form/submissionCount}" disabled="disabled" readonly="readonly" />
						</div>
						<div class="form-group col-lg-1">
							<label for="FORM_MAX_SUBMISSIONS">Maximum</label>
							<input type="text" class="form-control col-lg-6" name="FORM_MAX_SUBMISSIONS" id="FORM_MAX_SUBMISSIONS" value="{/data/form/maxSubmissions}" />
						</div>
					</div>
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:document.portal_form.ACTION.value='SAVE_FORM';document.portal_form.submit();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
