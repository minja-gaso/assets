<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<form action="profile" name="portal_form" method="post">
      <input type="hidden" name="PROFILE_URL" />
    	<xsl:apply-templates />
    </form>
	</xsl:template>
	<xsl:template match="root">
		<ol class="breadcrumb">
		  <li><a href="home">Home</a></li>
		  <li><a href="search">Search</a></li>
		  <li class="active"><xsl:value-of select="Epic_External_Name__c" /></li>
		</ol>
    <table class="table table-condensed">
      <xsl:for-each select="*">
        <xsl:sort select="name()" data-type="text" order="ascending" />
        <tr>
          <th><xsl:value-of select="name()" /></th>
          <th><xsl:value-of select="." /></th>
        </tr>
      </xsl:for-each>
    </table>
	</xsl:template>
</xsl:stylesheet>
