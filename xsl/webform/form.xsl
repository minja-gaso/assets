<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:variable name="status" select="/data/form/status" />
	<xsl:variable name="maxSubmissions" select="number(/data/form/maxSubmissions)" />
	<xsl:variable name="submissionCount" select="number(/data/form/submissionCount)" />
	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
			<xsl:if test="string-length(/data/form/skinUrl) &gt; 0">
				<xsl:attribute name="class">custom-skin</xsl:attribute>
			</xsl:if>
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="PREVIOUS_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="CURRENT_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="POST_FORM" value="false" />
	    <link href="/css/main.css" rel="stylesheet"/>
			<h1 class="form-group"><xsl:value-of select="/data/form/title" /></h1>
			<xsl:choose>
				<!-- if form ended -->
				<xsl:when test="$status = 'ended'">
					<div class="form-message">
						<xsl:value-of select="/data/form/messageEnded" disable-output-escaping="yes" />
					</div>
				</xsl:when>
				<!-- if max submissions is set to greater than 0 and total submissions is equal to or greater than max submissions -->
				<xsl:when test="$maxSubmissions &gt; 0 and $submissionCount &gt;= $maxSubmissions">
					<div class="form-message">
						<xsl:value-of select="/data/form/messageMaxSubmitted" disable-output-escaping="yes" />
					</div>
				</xsl:when>
				<!-- if none of cases above are met, display the form -->
				<xsl:otherwise>
					<xsl:if test="/data/form/status = 'draft'">
						<div class="alert alert-warning">
							<p>This survey is in <strong>draft</strong> mode.  Until it is in <strong>live</strong> mode the submissions will not be saved.</p>
							<dl>
								<dt>Benefits of <strong>draft</strong> mode include:</dt>
								<dd>Ensuring the look &amp; feel of the survey meet the administrators' standards.</dd>
								<dd>Verifying that all the questions and possible answers are on the screen.</dd>
								<dd>Testing of the various message screens (max submissions, one submission per user, thank-you/submitted, etc.)</dd>
							</dl>
						</div>
					</xsl:if>
					<xsl:call-template name="public_form" />
				</xsl:otherwise>
			</xsl:choose>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
	</xsl:template>

	<xsl:template name="public_form">
		<xsl:if test="count(/data/message[type='error']) &gt; 0">
			<div class="alert alert-danger" role="alert">
				<h2 class="error-heading">Please correct these errors before proceeding:</h2>
				<ul>
					<xsl:for-each select="/data/message[type='error']">
						<xsl:sort select="questionNumber" data-type="number" order="ascending" />
						<li>
							<xsl:value-of select="label" />
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:if>
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
		<xsl:for-each select="/data/form/question">
			<xsl:variable name="index" select="position()" />
			<xsl:variable name="questionId" select="id" />
			<div class="form-group">
				<xsl:choose>
					<xsl:when test="type = 'text'">
						<label for="{id}">
							<xsl:if test="/data/message/questionId = $questionId">
								<xsl:attribute name="class">error-style</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="concat(number, '. ', label)" />
							<xsl:if test="required = 'true'">
								<span class="fa fa-asterisk">
									<xsl:choose>
										<xsl:when test="string-length(/data/form/skinUrl) &gt; 0"><span class="sr-only asterisk">*</span></xsl:when>
										<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
									</xsl:choose>
								</span>
							</xsl:if>
						</label>
						<xsl:choose>
							<xsl:when test="filter = 'none'">
								<input type="text" class="form-control" name="QUESTION_{$questionId}" id="{id}">
									<xsl:attribute name="value">
										<xsl:choose>
											<xsl:when test="/data/submission/answer/questionId = $questionId">
												<xsl:value-of select="/data/submission/answer[questionId=$questionId]/answerValue" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="defaultAnswer" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</input>
							</xsl:when>
							<xsl:when test="filter = 'date'">
								<div class="input-group">
									<input type="text" class="form-control datepicker" name="QUESTION_{$questionId}" id="{id}" readonly="readonly" />
									<span class="input-group-addon" onclick="this.previousSibling.focus();"><span class="fa fa-calendar"><span class="sr-only">start date picker</span></span></span>
									<script>
									$(document).ready(function(){
										$("#<xsl:value-of select="id" />").datepicker();
									});
									</script>
								</div>
							</xsl:when>
							<xsl:when test="filter = 'email'">
								<div class="input-group">
									<input type="text" class="form-control" name="QUESTION_{$questionId}" id="{id}">
										<xsl:choose>
											<xsl:when test="string-length(defaultAnswer) &gt; 0">
												<xsl:attribute name="value">
													<xsl:value-of select="defaultAnswer" />
												</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="placeholder">
													<xsl:text>First.Last@example.com</xsl:text>
												</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="/data/submission/answer/questionId = $questionId">
											<xsl:attribute name="value">
												<xsl:value-of select="/data/submission/answer[questionId=$questionId]/answerValue" />
											</xsl:attribute>
										</xsl:if>
									</input>
									<span class="input-group-addon" onclick="this.previousSibling.focus();"><span class="fa fa-envelope"><span class="sr-only">enter email</span></span></span>
								</div>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="type = 'textarea'">
						<label for="{id}">
							<xsl:if test="/data/message/questionId = $questionId">
								<xsl:attribute name="class">error-style</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="concat(number, '. ', label)" />
							<xsl:if test="required = 'true'">
								<span class="fa fa-asterisk">
									<xsl:choose>
										<xsl:when test="string-length(/data/form/skinUrl) &gt; 0"><span class="sr-only asterisk">*</span></xsl:when>
										<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
									</xsl:choose>
								</span>
							</xsl:if>
						</label>
						<textarea class="form-control" name="QUESTION_{$questionId}" id="{id}">
							<xsl:choose>
								<xsl:when test="string-length(defaultAnswer) &gt; 0">
									<xsl:value-of select="defaultAnswer" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>&#x0A;</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</textarea>
					</xsl:when>
					<xsl:when test="type = 'radio' or type = 'checkbox'">
						<fieldset>
							<legend>
								<xsl:if test="/data/message/questionId = $questionId">
									<xsl:attribute name="class">error-style</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="concat(number, '. ', label)" />
								<xsl:if test="required = 'true'">
									<span class="fa fa-asterisk">
										<xsl:choose>
											<xsl:when test="string-length(/data/form/skinUrl) &gt; 0"><span class="sr-only asterisk">*</span></xsl:when>
											<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
										</xsl:choose>
									</span>
								</xsl:if>
							</legend>
							<xsl:for-each select="possibleAnswer">
								<xsl:variable name="possibleAnswerId" select="id" />
								<input type="hidden" name="QUESTION_{$questionId}" id="{$questionId}_hidden" />
								<div>
									<label>
										<xsl:if test="/data/message/questionId = $questionId">
											<xsl:attribute name="class">error-style</xsl:attribute>
										</xsl:if>
										<input name="QUESTION_{$questionId}" id="{$questionId}_{position()}" value="{id}">
											<xsl:attribute name="type">
												<xsl:choose>
													<xsl:when test="../type = 'radio'">radio</xsl:when>
													<xsl:when test="../type = 'checkbox'">checkbox</xsl:when>
												</xsl:choose>
											</xsl:attribute>
											<xsl:if test="/data/submission/answer/answerValue = $possibleAnswerId">
												<xsl:attribute name="checked">checked</xsl:attribute>
											</xsl:if>
										</input>
										<xsl:text><xsl:value-of select="label" /></xsl:text>
									</label>
								</div>
							</xsl:for-each>
						</fieldset>
					</xsl:when>
					<xsl:when test="type = 'pulldown'">
						<fieldset>
							<legend>
								<xsl:if test="/data/message/questionId = $questionId">
									<xsl:attribute name="class">error-style</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="concat(number, '. ', label)" />
								<xsl:if test="required = 'true'">
									<span class="fa fa-asterisk">
										<xsl:choose>
											<xsl:when test="string-length(/data/form/skinUrl) &gt; 0"><span class="sr-only asterisk">*</span></xsl:when>
											<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
										</xsl:choose>
									</span>
								</xsl:if>
							</legend>
							<select class="form-control" name="QUESTION_{$questionId}" id="{$questionId}_{position()}">
								<option />
								<xsl:for-each select="possibleAnswer">
									<xsl:variable name="possibleAnswerId" select="id" />
									<xsl:if test="/data/message/questionId = $questionId">
										<xsl:attribute name="class">error-style</xsl:attribute>
									</xsl:if>
									<option value="{id}">
										<xsl:if test="/data/submission/answer/answerValue = $possibleAnswerId">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
										<xsl:text><xsl:value-of select="label" /></xsl:text>
									</option>
								</xsl:for-each>
							</select>
						</fieldset>
					</xsl:when>
				</xsl:choose>
			</div>
		</xsl:for-each>
		<nav class="form-group">
			<ul class="pager">
				<li>
					<xsl:if test="/data/form/currentPage = 1">
						<xsl:attribute name="class">disabled</xsl:attribute>
					</xsl:if>
					<a href="#">
						<xsl:attribute name="href">
							<xsl:choose>
								<xsl:when test="/data/form/currentPage = 1">
									<xsl:text>javascript:;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat('javascript:document.portal_form.ACTION.value=', $apos, 'PREVIOUS_PAGE', $apos, ';document.portal_form.submit();')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Previous Page</xsl:text>
					</a>
				</li>
				<li class="current-page">Page <xsl:value-of select="/data/form/currentPage" /> of <xsl:value-of select="/data/form/lastPage" /></li>
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:choose>
								<xsl:when test="/data/form/currentPage = /data/form/lastPage">
									<xsl:value-of select="concat('javascript:document.portal_form.POST_FORM.value=', $apos, 'true', $apos, ';document.portal_form.ACTION.value=', $apos, 'SUBMIT_FORM', $apos, ';document.portal_form.submit();')" />
								</xsl:when>
								<xsl:otherwise>
										<xsl:value-of select="concat('javascript:document.portal_form.ACTION.value=', $apos, 'NEXT_PAGE', $apos, ';document.portal_form.submit();')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:choose>
							<xsl:when test="/data/form/currentPage = /data/form/lastPage"><xsl:text>Submit</xsl:text></xsl:when>
							<xsl:otherwise>Next Page</xsl:otherwise>
						</xsl:choose>
					</a>
					<!--
					<xsl:if test="/data/form/currentPage = /data/form/lastPage">
						<xsl:attribute name="class">disabled</xsl:attribute>
					</xsl:if>
					<a>
						<xsl:attribute name="href">
							<xsl:choose>
								<xsl:when test="/data/form/currentPage = /data/form/lastPage">
									<xsl:text>javascript:;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat('javascript:document.portal_form.ACTION.value=', $apos, 'NEXT_PAGE', $apos, ';document.portal_form.submit();')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Next Page</xsl:text>
					</a>
					-->
				</li>
			</ul>
		</nav>
		<!--
		<xsl:if test="count(/data/form/question) &gt; 0 and /data/form/currentPage = /data/form/lastPage">
			<div class="form-group text-center">
				<a class="btn btn-primary" href="javascript:document.portal_form.POST_FORM.value='true';document.portal_form.ACTION.value='SUBMIT_FORM';document.portal_form.submit();">Submit Form</a>
			</div>
		</xsl:if>
		-->
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
