<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <form action="search-results" name="portal_form" method="get">
      <input type="hidden" name="PROFILE_URL" />
    	<fieldset>
    		<legend>Find a Provider</legend>
    		<div class="form-group">
    			<label class="ADDRESS">Search a provider near you</label>
    			<input type="text" class="form-control" name="ADDRESS" id="ADDRESS" placeholder="Enter address, city or zip code"/>
    		</div>
    		<div class="form-group">
    			<label for="PRACTICE">or search a known location</label>
    			<select class="form-control" name="PRACTICE" id="PRACTICE">
    				<option selected="selected" disabled="disabled" value="">Clinic or hospital</option>
            <xsl:for-each select="/root/Hospital/records">
              <xsl:sort select="Name" type="text" data-order="ascending" />
              <option value="{Name}">
                <xsl:if test="$paramSpecialty = Name">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="Name" />
              </option>
            </xsl:for-each>
    			</select>
    		</div>
    		<div class="form-group">
    			<label for="SPECIALTY">Choose a specialty or service</label>
    			<select class="form-control" name="SPECIALTY" id="SPECIALTY">
    				<option disabled="disabled" value="">Specialty or Service</option>
            <xsl:for-each select="/root/ClinicalServices/records">
              <xsl:sort select="Name" type="text" data-order="ascending" />
              <option value="{Name}">
                <xsl:if test="$paramSpecialty = Name">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="Name" />
              </option>
            </xsl:for-each>
    			</select>
    		</div>
    		<div class="form-group">
    			<label for="GENDER visually-hidden">Gender</label>
    			<select class="form-control" name="GENDER" id="GENDER">
    				<option disabled="disabled" value="">Gender</option>
    				<option value="F">
              <xsl:if test="$paramGender = 'F'">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:text>Female</xsl:text>
            </option>
    				<option value="M">
              <xsl:if test="$paramGender = 'M'">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:text>Male</xsl:text>
            </option>
    			</select>
    		</div>
    		<div class="form-group">
    			<button type="submit" class="btn btn-primary">Submit</button>
    		</div>
    	</fieldset>
    </form>
  </xsl:template>
</xsl:stylesheet>
