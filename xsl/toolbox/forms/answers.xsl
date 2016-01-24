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
	<xsl:include href="form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="ANSWERS" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="ANSWER_ID" />
			<input type="hidden" name="QUESTION_NUMBER" />
			<input type="hidden" name="PAGE_BREAK_ID" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_DOWN" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_UP" />
			<!-- survey content -->
			<div class="row">
				<div class="col-lg-12">
					<nav>
							<xsl:call-template name="primary_navigation">
								<xsl:with-param name="SCREEN" select="'ANSWERS'" />
							</xsl:call-template>
					</nav>
					<!--
					<div class="form-row action-row action-top">
						<div class="btn-group">
							<a class="btn" href="javascript:submitForm();">Save</a>
							<a class="btn" href="javascript:formListScreen();">Back to Forms</a>
							<a class="btn" href="{$webformUrlToUse}" target="_blank">View Form</a>
						</div>
					</div>
					-->
					<h2>Self-Assessment Answers</h2>
					<div class="form-group">
						<div class="row">
							<div class="col-lg-8">
								<label>Add Answer(s)</label>
								<p class="help-block">Insert answers one on each line.  To add a value to the answer, separate by a comma.  Otherwise, a value of 0 will be associated with answer.</p>
								<textarea class="form-control" name="ANSWER_ADD" id="ANSWER_ADD" rows="3"><xsl:text>&#x0A;</xsl:text></textarea>
							</div>
							<div class="col-lg-4">
								<fieldset>
									<legend>Delimiter</legend>
									<div class="radio first">
										<label>
											<input type="radio" name="ANSWER_ADD_FILTER" value="carriage" checked="checked" />
											Carriage Return
										</label>
									</div>
									<!--
									<div class="radio">
										<label>
											<input type="radio" name="ANSWER_ADD_FILTER" value="comma" disabled="disabled" />
											Comma Separated
										</label>
									</div>
									<div class="radio disabled">
										<label>
											<input type="radio" name="ANSWER_ADD_FILTER" value="tab" disabled="disabled" />
											Tab Delimited
										</label>
									</div>
									-->
									<a class="btn btn-default add-answers" href="javascript:addAnswers();">Add Answers</a>
								</fieldset>
								<hr/>
								<p class="help-block">Copy &amp; paste the red text below into the box and click <strong>Add Answers</strong>.  Then, view the added answers in the table below.</p>
								<code>Never, 0<br/>Sometimes, 1<br/>Usually, 2<br/>Often,3<br/>Always,4</code>
							</div>
						</div>
					</div>
					<div class="form-group">
						<table class="table table-condensed table-striped">
							<caption>Available Answers</caption>
							<thead>
								<tr>
									<th class="col-lg-1 text-center">Value</th>
									<th class="col-lg-11">Label</th>
									<th class="col-lg-1 text-center">Delete</th>
								</tr>
							</thead>
							<tbody>
								<xsl:choose>
									<xsl:when test="count(/data/possibleAnswer) &gt; 0">
										<xsl:for-each select="/data/possibleAnswer">
											<tr>
												<th class="text-center">
														<input type="text" class="form-control input-sm text-center" name="ANSWER_VALUE_{id}" id="value_{id}" value="{value}" />
												</th>
												<th>
														<input type="text" class="form-control input-sm" name="ANSWER_ENTRY_{id}" id="label_{id}" value="{label}" />
												</th>
												<td class="text-center"><a href="javascript:deleteAnswer('{id}');"><span class="fa fa-trash fa-lg" /></a></td>
											</tr>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td class="bg-danger text-danger" colspan="3">This self-assessment survey <strong>should</strong> have answers but currently does not.  Please add them above.</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</tbody>
						</table>
					</div>
					<div class="form-row">
						<div class="btn-toolbar">
							<a class="btn btn-default" href="javascript:saveAnswers();">Save</a>
							<a class="btn btn-default" href="javascript:formListScreen();">Back to Forms</a>
							<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
