<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
	    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet"/>
	    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet"/>
	    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,200" rel="stylesheet"/>
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="PREVIOUS_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="CURRENT_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="POST_FORM" value="false" />
			<h1 class="form-group"><xsl:value-of select="/data/form/title" /></h1>
			<xsl:if test="count(/data/message[type='error']) &gt; 0">
				<div class="alert alert-danger" role="alert">
					<h2 class="error-heading">Please correct these errors before proceeding:</h2>
					<ul>
						<xsl:for-each select="/data/message[type='error']">
							<li><xsl:value-of select="concat('Question ', questionNumber, ' is required.')" /></li>
						</xsl:for-each>
					</ul>
				</div>
			</xsl:if>
			<xsl:for-each select="/data/form/question">
				<xsl:variable name="index" select="position()" />
				<xsl:variable name="questionId" select="id" />
				<div class="form-group">
					<xsl:choose>
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
								<xsl:for-each select="/data/possibleAnswer">
									<xsl:variable name="possibleAnswerId" select="id" />
									<xsl:variable name="possibleAnswerValue" select="value" />
									<input type="hidden" name="QUESTION_{$questionId}" id="{$questionId}_hidden" />
									<div>
										<label>
											<xsl:if test="/data/message/questionId = $questionId">
												<xsl:attribute name="class">error-style</xsl:attribute>
											</xsl:if>
											<input name="QUESTION_{$questionId}" id="{$questionId}_{position()}" value="{value}" type="radio">
												<xsl:if test="/data/submission/answer[position() = $index]/questionId = $questionId and /data/submission/answer[position() = $index]/answerValue = $possibleAnswerValue">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
											<xsl:text><xsl:value-of select="label" /></xsl:text>
										</label>
									</div>
								</xsl:for-each>
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
							<xsl:text>Previous <span class="hidden-xs">Page</span></xsl:text>
						</a>
					</li>
					<li class="current-page">Page <xsl:value-of select="/data/form/currentPage" /> of <xsl:value-of select="/data/form/lastPage" /></li>
					<li>
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
										<!--<xsl:value-of select="concat('javascript:changePage(', number(/data/form/currentPage) + 1, ')')" />-->
										<xsl:value-of select="concat('javascript:document.portal_form.ACTION.value=', $apos, 'NEXT_PAGE', $apos, ';document.portal_form.submit();')" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:text>Next <span class="hidden-xs">Page</span></xsl:text>
						</a>
					</li>
				</ul>
			</nav>
			<xsl:if test="count(/data/form/question) &gt; 0 and /data/form/currentPage = /data/form/lastPage">
				<div class="form-group text-center">
					<a class="btn btn-primary" href="javascript:document.portal_form.POST_FORM.value='true';document.portal_form.ACTION.value='SUBMIT_FORM';document.portal_form.submit();">Submit Form</a>
				</div>
			</xsl:if>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
    	<script src="/js/form.js?v=1"></script>
    	<script>
    	var content = document.getElementById('content');
    	content.id = 'survey';
    	</script>
	</xsl:template>
</xsl:stylesheet>
