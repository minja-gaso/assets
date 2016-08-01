<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<form action="profile" name="portal_form" method="post">
      <input type="hidden" name="PROFILE_URL" />
    	<xsl:apply-templates />
    </form>
	</xsl:template>
	<xsl:template match="root">
		<xsl:apply-templates select="records" />
    <!--
    <xmp><xsl:copy-of select="." /></xmp>
  -->
	</xsl:template>
  <xsl:template match="records">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h2 class="panel-title">
          <a href="javascript:document.portal_form.PROFILE_URL.value='{attributes/url}';document.portal_form.submit();"><xsl:value-of select="Name" /></a>
          <small class="pull-right">ID:&#160;<xsl:value-of select="Provider_ID__c" /></small>
        </h2>
        <p><small>REST API call: <xsl:value-of select="attributes/url" /></small></p>
      </div>
      <!--
      <div class="panel-body">
        <h3 class="text-center">About</h3>
        <p>Gender:&#160;<xsl:choose>
          <xsl:when test="Gender__c = 'M'">Male</xsl:when>
          <xsl:when test="Gender__c = 'F'">Female</xsl:when>
          <xsl:otherwise>Unknown</xsl:otherwise>
        </xsl:choose></p>
        <xsl:if test="Details__c != 'null'">
          deets<xsl:value-of select="Details__c" />
        </xsl:if>
        <xsl:if test="Affiliate_Physician__c != 'false'">
          IS AFF
        </xsl:if>
        <p><strong>Education</strong></p>
        <xsl:if test="Education != 'null'">
          TEST<xsl:value-of select="Education__c" />
        </xsl:if>
        <h3 class="text-center">Contact Info</h3>
        <ul class="list-group">
          <xsl:if test="Email != 'null'">
            <li class="list-group-item"><xsl:value-of select="Email" /></li>
          </xsl:if>
          <xsl:if test="Phone != 'null'">
            <li class="list-group-item"><xsl:value-of select="Phone" /></li>
          </xsl:if>
        </ul>
        <h3 class="text-center">Specialties</h3>
        <ul class="list-group">
          <xsl:for-each select="receivingProviderEpicSpecialty/array">
            <li class="list-group-item"><xsl:value-of select="." /></li>
          </xsl:for-each>
        </ul>
      </div>
    -->
    </div>
  </xsl:template>
</xsl:stylesheet>
