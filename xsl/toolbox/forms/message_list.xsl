<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="MESSAGES" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="MESSAGE_NAME" />
			<!-- survey content -->
			<xsl:variable name="webformBaseUrl" select="concat(/data/environment/serverName, 'webforms/self-assessment/')" />
			<xsl:variable name="webformUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'MESSAGES'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Public Messages</h2>
					<xsl:call-template name="messages" />
					<table class="table table-condensed">
						<caption>Messages</caption>
						<thead>
							<tr>
								<th class="col-lg-11 col-sm-11">Label</th>
								<th class="col-lg-1 col-sm-1 text-center">Edit</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Public <small>(visible when user is taking survey)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_PUBLIC');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
							<tr>
								<td>Ended <small>(visible when user tries taking an expired survey)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_ENDED');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
							<tr>
								<td>Max Submitted <small>(visible when the max number of submissions has been reached)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_MAX_SUBMISSIONS');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
							<tr>
								<td>One Submission Per User <small>(visible if user who previously submitted survey tries again)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_ONE_PER_USER');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
							<tr>
								<td>Not Started Yet <small>(visible when user tries to take survey before start date &amp; time)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_NOT_STARTED');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
							<tr>
								<td>Thank You <small>(message user sees after submitting form)</small></td>
								<td class="text-center"><a href="javascript:editMessage('MESSAGE_THANK_YOU');submitForm();"><span class="fa fa-pencil fa-lg" /></a></td>
							</tr>
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
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
