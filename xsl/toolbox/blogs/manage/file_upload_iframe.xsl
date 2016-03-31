<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
  <xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html lang="en-US">
      <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Image Upload for <xsl:value-of select="/data/calendar/title" /></title>
		    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="/css/resources/font-awesome-4.5.0/css/font-awesome.min.css" rel="stylesheet"/>
				<link href="/css/toolbox.css" rel="stylesheet" />
				<style type="text/css">
					body {
						margin: 24px;
					}
				</style>
      </head>
      <body id="iframe">
        <form action="" method="post" enctype="multipart/form-data">
					<fieldset>
						<legend>Upload File</legend>
						<div class="form-group">
							<label for="TOPIC_FILE_UPLOAD">Choose File</label>
							<input type="file" class="sr-only" name="TOPIC_FILE_UPLOAD" id="TOPIC_FILE_UPLOAD" />
							<div class="input-group">
								<input type="text" class="form-control" name="TOPIC_FILE_NAME" id="TOPIC_FILE_NAME" />
								<span class="input-group-addon" id="browse-button">
									<span class="fa fa-image" />&#160;Browse...
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="TOPIC_FILE_TYPE">File Type</label>
							<div class="styled-select">
								<select class="form-control" name="TOPIC_FILE_TYPE" id="TOPIC_FILE_TYPE">
									<xsl:if test="count(/data/blog/topic/file[type='large']) = 0">
										<option value="large">Large Image</option>
									</xsl:if>
									<xsl:if test="count(/data/blog/topic/file[type='thumbnail']) = 0">
										<option value="thumbnail">Thumbnail Image</option>
									</xsl:if>
									<option value="embedded">Embedded Image</option>
									<option value="additional">Additional File</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="TOPIC_FILE_DESCRIPTION">Describe</label>
							<p class="help-block">Provide a short, detailed description of the image to help improve accessibility for the visually impaired and disabled.</p>
							<input type="text" class="form-control" name="TOPIC_FILE_DESCRIPTION" id="TOPIC_FILE_DESCRIPTION" />
						</div>
						<button class="btn btn-primary" onclick="uploadClick();">Upload</button>
					</fieldset>
        </form>
        <script>
          var fileInput = document.getElementById('TOPIC_FILE_UPLOAD');
          fileInput.addEventListener('change', function(){
            updateFileNameInput(this);
          });

          var fileNameInput = document.getElementById('TOPIC_FILE_NAME');
          fileNameInput.addEventListener('click', function(){
            openFileBrowser();
          });

          var browseButton = document.getElementById('browse-button');
          browseButton.addEventListener('click', function(){
            openFileBrowser();
          });

          function openFileBrowser()
          {
            document.getElementById('TOPIC_FILE_UPLOAD').click();
          }
          function updateFileNameInput(element)
          {
            document.getElementById('TOPIC_FILE_NAME').value = element.value;
          }

					function uploadClick()
					{
						window.parent.document.getElementById('my_popup_close').click();
						window.parent.document.getElementById('uploaded').click();
					}
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
