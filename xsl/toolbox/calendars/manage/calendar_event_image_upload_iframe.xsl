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
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet"/>
				<style type="text/css">
					body {
						margin: 24px;
					}
				</style>
      </head>
      <body>
        <form action="" method="post" enctype="multipart/form-data">
					<fieldset>
						<legend>Upload Event Image</legend>
						<div class="form-group">
							<label for="EVENT_IMAGE_UPLOAD">Choose File</label>
							<input type="file" class="sr-only" name="EVENT_IMAGE_UPLOAD" id="EVENT_IMAGE_UPLOAD" />
							<div class="input-group">
								<input type="text" class="form-control" name="EVENT_IMAGE_NAME" id="EVENT_IMAGE_NAME" />
								<span class="input-group-addon" id="browse-button">
									<span class="fa fa-image" />&#160;Browse...
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="EVENT_IMAGE_DESCRIPTION">Describe</label>
							<p class="help-block">Provide a short, detailed description of the image to help improve accessibility for the visually impaired and disabled.</p>
							<input type="text" class="form-control" name="EVENT_IMAGE_DESCRIPTION" id="EVENT_IMAGE_DESCRIPTION" />
						</div>
						<button class="btn btn-primary" onclick="window.parent.document.getElementById('my_popup_close').click();window.parent.document.getElementById('uploaded').click();">Upload</button>
					</fieldset>
        </form>
        <script>
          var fileInput = document.getElementById('EVENT_IMAGE_UPLOAD');
          fileInput.addEventListener('change', function(){
            updateFileNameInput(this);
          });

          var fileNameInput = document.getElementById('EVENT_IMAGE_NAME');
          fileNameInput.addEventListener('click', function(){
            openFileBrowser();
          });

          var browseButton = document.getElementById('browse-button');
          browseButton.addEventListener('click', function(){
            openFileBrowser();
          });

          function openFileBrowser()
          {
            document.getElementById('EVENT_IMAGE_UPLOAD').click();
          }
          function updateFileNameInput(element)
          {
            document.getElementById('EVENT_IMAGE_NAME').value = element.value;
          }
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
