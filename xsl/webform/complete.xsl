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
			<xsl:choose>
				<xsl:when test="/data/form/type = 'survey'">
					<p>The form has been completed.  Thanks for taking it!</p>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="score" select="/data/form/score" />
					<p>You scored a <strong><xsl:value-of select="$score" /></strong> on the self-assessment.</p>
					<p id="summary"></p>
					<script>
						var summary = document.getElementById('summary');
						<xsl:for-each select="/data/score">
							<xsl:variable name="minScore" select="begin" />
							<xsl:variable name="maxScore" select="end" />
							<xsl:variable name="case">
								<xsl:value-of select="$minScore" /> &gt;= <xsl:value-of select="$score" /> &amp;&amp; <xsl:value-of select="$score" /> &lt;= <xsl:value-of select="$maxScore" />
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="position() = 1">
									if(<xsl:value-of select="$case" />)
								</xsl:when>
								<xsl:when test="position() = last()">
									else
								</xsl:when>
								<xsl:otherwise>
									else if(<xsl:value-of select="$case" />)
								</xsl:otherwise>
							</xsl:choose>
							{
								summary.innerHTML = '<xsl:value-of select="summary" />';
							}
						</xsl:for-each>
					</script>
				</xsl:otherwise>
			</xsl:choose>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
    	<script src="/js/form.js?v=1"></script>
	</xsl:template>
</xsl:stylesheet>
