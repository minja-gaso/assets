<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="{$QUESTION_LIST_ACTION}" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="QUESTION_ID" />
			<input type="hidden" name="QUESTION_NUMBER" />
			<input type="hidden" name="PAGE_BREAK_ID" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_DOWN" />
			<input type="hidden" name="MOVE_QUESTION_NUMBER_UP" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'QUESTIONS_AND_ANSWERS'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<!--
				<div class="form-row action-row action-top">
					<div class="btn-group">
						<a class="btn" href="javascript:submitForm();">Save</a>
						<a class="btn" href="javascript:formListScreen();">Back to Forms</a>
						<a class="btn" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
				-->
				<h2>Self-Assessment Questions</h2>
				<xsl:call-template name="messages" />
				<xsl:if test="number(/data/form/submissionCount) &gt; 0">
					<div class="alert alert-warning">
						You cannot modify the questions once the form has submissions.  (<strong><xsl:value-of select="/data/form/submissionCount" /></strong> submissions to date)
					</div>
				</xsl:if>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th class="col-lg-1 text-center">Question</th>
							<th class="col-lg-1 text-center">Pagebreak</th>
							<!--
							<th class="col-lg-1 text-center">ID</th>
							-->
							<th class="col-lg-1 text-center">Number</th>
							<th class="col-lg-7">Label</th>
							<th class="col-lg-1 text-center">Delete</th>
							<th class="col-lg-2 text-center">Reorder</th>
						</tr>
					</thead>
					<tbody>
						<tr class="pagebreak-row">
							<th class="text-center">
								<xsl:choose>
									<xsl:when test="count(/data/form/question) = 0">
										<a href="javascript:createQuestion();submitForm();"><span class="fa fa-plus-circle fa-lg" /></a>
									</xsl:when>
									<xsl:otherwise>&#160;</xsl:otherwise>
								</xsl:choose>
							</th>
							<th colspan="2">&#160;</th>
							<td class="text-center">Page 1</td>
							<td colspan="3">&#160;</td>
						</tr>
						<xsl:for-each select="/data/form/question">
							<xsl:variable name="questionType">
								<xsl:choose>
									<xsl:when test="type = 'text'">QUESTION_TYPE_TEXT</xsl:when>
									<xsl:when test="type = 'textarea'">QUESTION_TYPE_TEXTAREA</xsl:when>
									<xsl:when test="type = 'radio'">QUESTION_TYPE_RADIO</xsl:when>
									<xsl:when test="type = 'checkbox'">QUESTION_TYPE_CHECKBOX</xsl:when>
									<xsl:when test="type = 'pulldown'">QUESTION_TYPE_PULLDOWN</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:if test="page != preceding-sibling::*[1]/page">
								<tr class="pagebreak-row">
									<th colspan="3">&#160;</th>
									<td class="text-center">Page <xsl:value-of select="page" /></td>
									<td>&#160;</td>
									<td class="text-center"><a href="javascript:deletePageBreak({page});submitForm();"><span class="fa fa-trash fa-lg" /></a></td>
									<td>&#160;</td>
								</tr>
							</xsl:if>
							<tr class="question-row">
								<th class="text-center">
									<xsl:choose>
										<xsl:when test="number(/data/form/submissionCount) &gt; 0">
											<span class="fa fa-plus-square fa-lg fa-disabled" />
										</xsl:when>
										<xsl:otherwise>
											<a href="javascript:insertQuestion('{id}');submitForm();"><span class="fa fa-plus-square fa-lg" /></a>
										</xsl:otherwise>
									</xsl:choose>
								</th>
								<td class="text-center">
									<xsl:choose>
										<xsl:when test="number(/data/form/submissionCount) &gt; 0">
											<span class="fa fa-plus-square fa-lg fa-disabled" />
										</xsl:when>
										<xsl:when test="page != following-sibling::*[1]/page or position() = last()">
											<span class="fa fa-plus-square fa-lg fa-disabled" />
										</xsl:when>
										<xsl:otherwise>
											<a href="javascript:insertPageBreak({number});submitForm();"><span class="fa fa-plus-square fa-lg" /></a>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class="text-center">
									<xsl:text><xsl:value-of select="number" /></xsl:text>
								</td>
								<td class="text-left">
									<input type="hidden" name="QUESTION_ID_LIST" value="{id}" />
									<input type="hidden" name="QUESTION_ORDER_LIST" value="{number}" />
									<input type="text" class="form-control input-sm" name="QUESTION_ENTRY_{id}" id="{id}" value="{label}">
										<xsl:if test="number(/data/form/submissionCount) &gt; 0">
											<xsl:attribute name="disabled">disabled</xsl:attribute>
										</xsl:if>
									</input>
								</td>
								<td class="text-center">
									<xsl:choose>
										<xsl:when test="number(/data/form/submissionCount) &gt; 0">
											<span class="fa fa-plus-circle fa-lg fa-disabled" />
										</xsl:when>
										<xsl:otherwise>
											<a href="javascript:deleteQuestion('{id}');submitForm();"><span class="fa fa-trash fa-lg" /></a>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class="text-center">
									<!-- move up -->
									<xsl:choose>
										<xsl:when test="number(/data/form/submissionCount) &gt; 0">
											<span class="arrow arrow-up arrow-disabled"><span class="fa fa-arrow-up fa-lg" />&#160;</span>
										</xsl:when>
										<xsl:when test="position() != 1">
											<a class="arrow arrow-up arrow-active" href="javascript:swapQuestions('SWAP_UP', {number});submitForm();"><span class="fa fa-arrow-up fa-lg" /></a>
										</xsl:when>
										<xsl:otherwise>
											<span class="arrow arrow-up arrow-disabled"><span class="fa fa-arrow-up fa-lg" />&#160;</span>
										</xsl:otherwise>
									</xsl:choose>
									<!-- move down -->
									<xsl:choose>
										<xsl:when test="number(/data/form/submissionCount) &gt; 0">
											<span class="arrow arrow-down arrow-disabled"><span class="fa fa-arrow-down fa-lg" /></span>
										</xsl:when>
										<xsl:when test="position() != last()">
											<a class="arrow arrow-down arrow-active" href="javascript:swapQuestions('SWAP_DOWN', {number});submitForm();"><span class="fa fa-arrow-down fa-lg" /></a>
										</xsl:when>
										<xsl:otherwise>
											<span class="arrow arrow-down arrow-disabled"><span class="fa fa-arrow-down fa-lg" /></span>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<div class="form-row">
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveQuestions();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
