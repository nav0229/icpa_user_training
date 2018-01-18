({

    MAX_FILE_SIZE: 4500000, /* 6 000 000 * 3/4 to account for base64 */
    CHUNK_SIZE: 450000, /* Use a multiple of 4 */
    /* 
     * This method will read the file conents and sends to upload method
     */
	logMessage : function(msg){
    	console.log(msg);
    	var h = jQuery("#diagnosticLogMessageStream").html().trim();
    	if (h.length>0)
        {
            h = h + "<hr />";
        }
		jQuery("#diagnosticLogMessageStream").html(h+msg);    
	},
    saveFile: function(component, recordId, fileInput)
    {
            var file = fileInput.files[0];
        
        // Display an alert if the file size exceeds maximum allowed size
        if (file.size > this.MAX_FILE_SIZE) {
            alert('File size cannot exceed ' + this.MAX_FILE_SIZE + ' bytes.\n' +
                  'Selected file size: ' + file.size);
            return;
        }
        
        var fr = new FileReader();
        
        var self = this;
        fr.onload = $A.getCallback(function() {
            var fileContents = fr.result;
            var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
            
            fileContents = fileContents.substring(dataStart);

            self.upload(component, file, fileContents, recordId); 
        });
        
        fr.readAsDataURL(file);
    }
    ,
    
    /*
     * This method will split file into Chunks and call "uploadChunk" method to save the  files in chunks 
     */
    upload: function(component, file, fileContents, recordId) {
        var fromPos = 0;
        var toPos = Math.min(fileContents.length, fromPos + this.CHUNK_SIZE);
        var lastChunk = 'N';
        
        if (toPos == fileContents.length)
                {
                    lastChunk = 'Y';
                    //alert(lastChunk);
                }
        
        // start with the initial chunk
        this.uploadChunk(component, file, fileContents, fromPos, toPos, '', recordId, lastChunk); 
    },
    
    /*
     * This method will call "saveTheChunk" apex method to save the attachment chunk into Case
     */
    uploadChunk : function(component, file, fileContents, fromPos, toPos, attachId, recordId, lastChunk) {
        var action = component.get("c.saveTheChunk"); 
        var chunk = fileContents.substring(fromPos, toPos);
                
        action.setParams({
            parentId: recordId,
            fileName: file.name,
            base64Data: encodeURIComponent(chunk), 
            contentType: file.type,
            fileId: attachId,
            lastChunk: lastChunk
        });
        
        var self = this;
        action.setCallback(this, function(a) {
            attachId = a.getReturnValue();

	      this.logMessage("uploadChunk: chunkComplete; ["+file.name+"] "+fromPos+"-"+toPos+"/"+fileContents.length+" lastChunk:"+lastChunk);
            
            fromPos = toPos;
            toPos = Math.min(fileContents.length, fromPos + self.CHUNK_SIZE);
            
            if (fromPos < toPos) {
                
                if (toPos == fileContents.length)
                {
                    lastChunk = 'Y';
                    //alert(lastChunk);
                }
                
                self.uploadChunk(component, file, fileContents, fromPos, toPos, attachId, recordId, lastChunk);  
            }
        });
        
        
        window.setTimeout(
            $A.getCallback(function() {             
                $A.enqueueAction(action); 
           }), 500);
        
        
    }  
    
})