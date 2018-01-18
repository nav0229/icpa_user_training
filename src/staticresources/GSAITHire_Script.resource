var humanAnswerNum = -1;
    var humanAnswerWord = '';

        function nameValidation() { 
          //alert(document.getElementById('appPage:appForm:frmAddSkills').value);   
          var nametxt = document.getElementById('frmFullName').value;
          var emailtxt = document.getElementById('frmEmailAddress').value;
          var addskillstxt = document.getElementById('appPage:appForm:frmAddSkills').value;
          var vPrefs = document.getElementsByName('frmVetPref');          
          var vURL1 = (document.getElementById('frmLink1').value).replace(/\s/g,'');
          var vURL2 = (document.getElementById('frmLink2').value).replace(/\s/g,'');
          var vURL3 = (document.getElementById('frmLink3').value).replace(/\s/g,'');
          document.getElementById('frmLink1').value = vURL1;
          document.getElementById('frmLink2').value = vURL2;
          document.getElementById('frmLink3').value = vURL3;
            //var ifrResume = document.getElementById('appPage:appForm:frmResume');
            //var ifrResumeHTML = $(ifrResume).contents().find('html:first').find('body:first').html();
          var formvalid = true;
          var checkHumanResult = checkAnswer();
          var checkPhone= phonevalidation();
          var vpreftxt = '';
                for (var i = 0, length = vPrefs.length; i < length; i++) {
                    if (vPrefs[i].checked) {
                        //alert(vPrefs[i].value);
                        vpreftxt = (vPrefs[i].value);
                        break;
                    }
                }  
          if (nametxt == null || nametxt.length == 0 || nametxt.trim()=="") {
            alert('Name is required.');
            document.getElementById('frmFullName').focus();
            return false;
          } else if (emailtxt == null || emailtxt.length == 0 || emailtxt.trim() =="") {
            alert('Email Address is required.');
            document.getElementById('frmEmailAddress').focus();
            return false;
          } else if(document.getElementsByName('frmVetStatus')[0].checked &&
            vpreftxt == "" ) {
            alert('Veterans Preference claim is required.');
            document.getElementById('frmVetPref1').focus();
            return false;
          }else if (checkPhone==0) {
              alert("Not a valid phone number.");
              document.getElementById('frmPhoneNumber').focus();
              return false;
            } else if (emailtxt.length > 0) {
            var reg = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!reg.test(emailtxt)){
              alert("Not a valid Email address.");
              document.getElementById('frmEmailAddress').focus();
              return false;
            } else if ((vURL1 != null) && (vURL1.length > 0) && (! isValidURL(vURL1)) )  {
              alert("Not a valid URL. Be sure to include http:// or https:// in the URL.");
              document.getElementById('frmLink1').value="";
              document.getElementById('frmLink1').focus();
              return false;
            } else if ((vURL2 != null) && (vURL2.length > 0) && (! isValidURL(vURL2)) )  {
              alert("Not a valid URL. Be sure to include http:// or https:// in the URL.");
              document.getElementById('frmLink2').value="";
              document.getElementById('frmLink2').focus(); 
              return false;
            } else if ((vURL3 != null) && (vURL3.length > 0) && (! isValidURL(vURL3)) )  {
              alert("Not a valid URL. Be sure to include http:// or https:// in the URL.");
              document.getElementById('frmLink3').value="";
              document.getElementById('frmLink3').focus(); 
              return false;
            } else if (addskillstxt.length > 255) {
              alert('Other skills is longer than the 255 character limit.');
              document.getElementById('appPage:appForm:frmAddSkills').focus();
              return false;
            } else if (checkHumanResult == 0 ) {
              alert("Please make sure to correctly complete the addition problem at the bottom.");
              document.getElementById('inptHuman').focus();
              return false;
            }  else { 
              //alert(document.getElementById('appPage:appForm:frmAddSkills').value);
              return true;
            }
          } 
        }

        //verify user calculation
        function checkAnswer() {
          var returnResult = 0;
          var curAnswer = $('#inptHuman').val().toLowerCase();
          if ((curAnswer == humanAnswerNum) || (curAnswer == humanAnswerWord)) {returnResult = 1;}
          return returnResult;
        }

        //verify phone number
        function phonevalidation(){
            
        	var phoneno = document.getElementById('frmPhoneNumber').value; 
        	var phn = /^\d{10}$/;
        	var  result=0;
            console.log(phoneno);
            if (phn.test(phoneno) || phoneno == null || phoneno.length == 0 || phoneno.trim()==""){
        		result=1;
            }
          return result;
        }

        function actionFunction(){
        return true;
        }

        function isValidURL(url){
          var userURL = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
          if(userURL.test(url)){
           return true;
         }else {return false;}
        }
           
        $(document).ready(function () {

        //reset all fields
        $("form").each(function(index) {
          $(this).trigger("reset");
        });

        var errorLiHTML = $('.message').find('li').html();
        if (errorLiHTML) {
          if (errorLiHTML.indexOf('Resume: Resume: data value too large')>-1) {
            $('.message').remove();
            alert('Your résumé is longer than the 32,000 character limit. Please resubmit your application with a smaller résumé.'); 
          }
        }

        addHumanCheck();
        //insert human verification formula
        function addHumanCheck() {
          var arrVerifyNums = genRandNums();
          $('#lblInptHuman').text('Confirm that you are human: What is ' + arrVerifyNums[0] + ' plus ' + arrVerifyNums[1] + '?');
        }

        //generate random numbers and result for human verification
        function genRandNums() {
          var randNum1 = Math.floor(Math.random()*11);
          var randNum2 = Math.floor(Math.random()*11);
          var randNumSum = randNum1 + randNum2;

            //humanAnswer = randNum1 + randNum2;
            var arrRandNums = [randNum1,randNum2,randNumSum];
            var arrRandNumsEng = getNumWords(arrRandNums);
            humanAnswerNum = randNumSum;
            humanAnswerWord = arrRandNumsEng[2];
            return arrRandNumsEng;
          }

          //convert numbers to words
          function getNumWords(arrRandNumsNums) {
            var allNumWords = ['zero','one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen','twenty'];
            return [allNumWords[arrRandNumsNums[0]],allNumWords[arrRandNumsNums[1]],allNumWords[arrRandNumsNums[2]]];
          }

          // Assign value of Veteran's Status radio buttons to hidden apex field
          $('input[id*="frmVetStatus"]').click(function() {
            $('[id*=hiddenVeteranStatus]').val(this.value);
          }); 
          
          // Assign value of Veteran's Preference radio buttons to hidden apex field
          $('input[id*="frmVetPref"]').click(function() {
            $('[id*=hiddenVeteransPref]').val(this.value);
          });  

          // Assign value of US Citizen radio buttons to hidden apex field
          $('input[id*="frmUSCitizen"]').click(function() {
            $('[id*=hiddenUSCitizen]').val(this.value);
          });
          
          // Assign full name
          $('input[id="frmFullName"]').change(function() {
            $('[id*=hiddenFullName]').val(this.value);                
          });
          
          // Assign email address
          $('input[id="frmEmailAddress"]').change(function() {
            $('[id*=hiddenEmailAddress]').val(this.value);        
          });
          
          // Assign phone number
          $('input[id="frmPhoneNumber"]').change(function() {
            $('[id*=hiddenPhoneNumber]').val(this.value);        
          });
          
          // Assign city
          $('input[id="frmCity"]').change(function() {
            $('[id*=hiddenCity]').val(this.value);        
          });
          
          // Assign current employer
          $('input[id="frmCurrentEmployer"]').change(function() {
            $('[id*=hiddenCurrentEmployer]').val(this.value);        
          });
          
          // Assign Link1
          $('input[id="frmLink1"]').change(function() {
            $('[id*=hiddenLink1]').val(this.value);        
          });
          
          // Assign Link2
          $('input[id="frmLink2"]').change(function() {
            $('[id*=hiddenLink2]').val(this.value);        
          });
          
          // Assign Link3
          $('input[id="frmLink3"]').change(function() {
            $('[id*=hiddenLink3]').val(this.value);        
          });
            
            
            // Begin Skills
            
          // Assign values of selected Skills to hidden apex field //
          function populateSkills(){
            $('select[id*="frmSkills"]').each(function() {
              var curHiddenField = 'hidden' + $(this).attr('id').substring(9);
                  //console.log(curHiddenField);
                  //console.log($(this).val());
                  $('input[id*="'+curHiddenField+'"]').val($(this).val());
                });
          }
            
          // Run populateSkills function to build out hidden field value for Skills__c
          $('select[id*="frmSkills"]').on('change', function() {
            populateSkills()
          }).change();
          
          // End Skills
          
          // Assign Position Interested 
          $('input[id="frmPosition"]').change(function() {
            $('[id*=hiddenPosition]').val(this.value);        
          }); 

	  // Assign Referral Code
          $('input[id="frmReferral"]').change(function() {
            $('[id*=hiddenReferral]').val(this.value);        
          });

          // display appropriate Veterans Status text and options
          $('[name="frmVetStatus"]').on('click', function() {
            $('#vet-pref-details').hide('fast');     
          });    

          $('#frmVetStatusA').on('click', function() {
            $('#vet-pref-details').show();   
          });  
            
          
          // prepend http:
          var inputval = "http://";
          $('input[id*="frmLink"]').focusin(function() {
            // if textbox is empty or got the default value
            if ($(this).val().indexOf("http://") == -1 && $(this).val().indexOf("https://") == -1) {
              $(this).val(inputval + $(this).val());
            }
          }).blur(function() {
            // if textbox is empty or just contains your value
            if ($(this).val() == "" || $(this).val() == "http://") {
              $(this).val('');
            }
          });
        });

        var urlParams;
        // Grabs any URL parameters
        (window.onpopstate = function () {
          var match,
          pl     = /\+/g,  // Regex for replacing addition symbol with a space
          search = /([^&=]+)=?([^&]*)/g,
          decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
          query  = window.location.search.substring(1);
          urlParams = {};
          while (match = search.exec(query))
            urlParams[decode(match[1])] = decode(match[2]);
        })();