<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="PREVIOUS_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="CURRENT_PAGE" value="{/data/form/currentPage}" />
    	<link rel="stylesheet" type="text/css" href="/css/main.css?v=1" />
			<h1 class="form-group"><xsl:value-of select="/data/form/title" /></h1>
			<div class="form-message">
				<xsl:choose>
					<!--
					<xsl:when test="/data/form/status = 'draft'">
						<xsl:value-of select="/data/form/messageNotStarted" disable-output-escaping="yes" />
					</xsl:when>
					<xsl:when test="/data/form/status = 'ended'">
						<xsl:value-of select="/data/form/messageEnded" disable-output-escaping="yes" />
					</xsl:when>
					-->
					<xsl:when test="/data/form/status = '123'">
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/data/form/messageThankYou" disable-output-escaping="yes" />
					</xsl:otherwise>
				</xsl:choose>
			</div>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
    	<script src="/js/form.js?v=1"></script>
	</xsl:template>
</xsl:stylesheet>
