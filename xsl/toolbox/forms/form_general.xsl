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
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'GENERAL'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<a class="btn btn-default" href="javascript:document.portal_form.ACTION.value='SAVE_FORM';submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
					<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
				</div>
				<h2>General Information</h2>
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
		<div class="form-group">
			<label for="FORM_TITLE">Title</label>
			<input type="text" class="form-control" name="FORM_TITLE" id="FORM_TITLE" value="{/data/form/title}" />
		</div>
		<div class="form-group">
			<div><label>Status</label></div>
			<p class="help-block">
				You may add, edit and delete questions in <strong>Draft</strong> mode.  Any submissions during this mode are not stored.<br/>
				Submitted surveys are stored in <strong>Live</strong> mode.  Once this mode is saved, you cannot change the status back to <strong>Draft</strong>.<br/>
				If the survey mode is set to <strong>Ended</strong>, users see a message notifying them they cannot take the survey.  The message can be edited on the <span class="text-info"><strong>Messages</strong></span> tab.
			</p>
			<label class="inline">
			  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_DRAFT" value="draft">
					<xsl:if test="/data/form/status = 'draft'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<span>Draft</span>
			</label>
			<label class="inline">
			  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_LIVE" value="live">
					<xsl:if test="/data/form/status = 'live'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<span>Live</span>
			</label>
			<label class="inline">
			  <input type="radio" name="FORM_STATUS" id="FORM_STATUS_ENDED" value="ended">
					<xsl:if test="/data/form/status = 'ended'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<span>Ended</span>
			</label>
		</div>
		<div class="form-group">
			<label for="FORM_URL">Standard URL</label>
			<p class="help-block">If you do not care about SEO, feel free to link to this URL.</p>
			<div class="input-group url">
				<span class="input-group-addon"><xsl:value-of select="$webformBaseUrl" /></span>
				<input type="text" class="form-control" name="FORM_URL" id="FORM_URL" value="{/data/form/id}" />
				<input type="hidden" name="HIDDEN_FORM_URL" id="HIDDEN_FORM_URL" value="{$webformById}" />
				<a href="{concat($webformBaseUrl, /data/form/id)}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
			</div>
		</div>
		<div class="form-group">
			<label for="FORM_PRETTY_URL">Pretty URL</label>
			<p class="help-block">We recommend a <em>Pretty URL</em>. You may use alphanumeric characters, hyphens, underscores and periods. This will be better for SEO.</p>
			<div class="input-group url">
				<span class="input-group-addon"><xsl:value-of select="$webformBaseUrl" /></span>
				<input type="text" class="form-control" name="FORM_PRETTY_URL" id="FORM_PRETTY_URL" value="{/data/form/prettyUrl}" />
				<a href="{$webformPrettyUrl}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
			</div>
		</div>
		<div class="row">
			<xsl:variable name="startDate">
				<xsl:variable name="year" select="substring(/data/form/startDate,1,4)" />
				<xsl:variable name="month" select="substring(/data/form/startDate,6,2)" />
				<xsl:variable name="day" select="substring(/data/form/startDate,9,2)" />
				<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
			</xsl:variable>
			<xsl:variable name="endDate">
				<xsl:variable name="year" select="substring(/data/form/endDate,1,4)" />
				<xsl:variable name="month" select="substring(/data/form/endDate,6,2)" />
				<xsl:variable name="day" select="substring(/data/form/endDate,9,2)" />
				<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
			</xsl:variable>
			<div class="form-group col-xs-4 col-sm-3">
				<label for="FORM_START_DATE">Start Date</label>
				<input type="text" class="form-control datepicker" name="FORM_START_DATE" id="FORM_START_DATE" value="{$startDate}" />
			</div>
			<div class="form-group col-xs-4 col-sm-3">
				<label for="FORM_END_DATE">End Date</label>
				<input type="text" class="form-control datepicker" name="FORM_END_DATE" id="FORM_END_DATE" value="{$endDate}" />
			</div>
			<script>
				$(document).ready(function(){
				  $("#FORM_START_DATE").datepicker({
						changeMonth: true,
						changeYear: true,
				    dateFormat: "mm-dd-yy",
				    onSelect: function(selected){
				       $("#FORM_END_DATE").datepicker("option","minDate", selected)
				    }
				  }).datepicker("setDate", new Date("<xsl:value-of select="$startDate" />"));
				  $("#FORM_END_DATE").datepicker({
						changeMonth: true,
						changeYear: true,
				    dateFormat: "mm-dd-yy",
				    onSelect: function(selected){
				       $("#FORM_START_DATE").datepicker("option","maxDate", selected)
				    }
				  }).datepicker("setDate", new Date("<xsl:value-of select="$endDate" />"));
				});
			</script>
		</div>
		<div class="row">
			<p class="col-lg-12">
				<strong>Submissions</strong>
				<small class="help-block">
					If <strong>Max Submissions</strong> is greater than 0 <u>AND</u> is less than or equal to <strong>Total Submissions</strong>, users receive a "max submissions limit reached" message.
					This message can be customized on the <span class="text-danger">Messages</span> tab.
				</small>
			</p>
			<div class="form-group col-xs-2">
				<label for="FORM_TOTAL_SUBMISSIONS">Total</label>
				<input type="text" class="form-control" name="FORM_TOTAL_SUBMISSIONS" id="FORM_TOTAL_SUBMISSIONS" value="{/data/form/submissionCount}" disabled="disabled" readonly="readonly" />
			</div>
			<div class="form-group col-xs-2">
				<label for="FORM_MAX_SUBMISSIONS">Maximum</label>
				<input type="text" class="form-control col-lg-6" name="FORM_MAX_SUBMISSIONS" id="FORM_MAX_SUBMISSIONS" value="{/data/form/maxSubmissions}" />
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
