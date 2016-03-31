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
			<input type="hidden" name="SCREEN" value="ANSWERS" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="ANSWER_ID" />
			<input type="hidden" name="QUESTION_NUMBER" />
			<input type="hidden" name="PAGE_BREAK_ID" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_DOWN" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_UP" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'ANSWERS'" />
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
				<h2>Self-Assessment Answers</h2>
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
			<div class="row">
				<div class="col-lg-8 col-sm-8">
					<label>Add Answer(s)</label>
					<p class="help-block">Insert answers one on each line.  To add a value to the answer, separate by a comma.  Otherwise, a value of 0 will be associated with answer.</p>
					<textarea class="form-control" name="ANSWER_ADD" id="ANSWER_ADD" rows="3"><xsl:text>&#x0A;</xsl:text></textarea>
				</div>
				<div class="col-lg-4 col-sm-4">
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
						<a class="btn btn-default add-answers" href="javascript:addAnswers();submitForm();">Add Answers</a>
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
							<xsl:apply-templates select="../possibleAnswer" />
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
	</xsl:template>
	<xsl:template match="possibleAnswer">
		<tr>
			<th class="text-center">
					<input type="text" class="form-control input-sm text-center" name="ANSWER_VALUE_{id}" id="value_{id}" value="{value}" />
			</th>
			<th>
					<input type="text" class="form-control input-sm" name="ANSWER_ENTRY_{id}" id="label_{id}" value="{label}" />
			</th>
			<td class="text-center"><a href="javascript:deleteAnswer('{id}');submitForm();"><span class="fa fa-trash fa-lg" /></a></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
