<aura:application >
    <ltng:require styles="/resource/Lgt_InputLookup/css/bootstrap.min.css,
                /resource/SLDS230/assets/styles/salesforce-lightning-design-system.min.css"
                  scripts="/resource/Lgt_InputLookup/js/jquery-2.2.4.min.js" 
        afterScriptsLoaded="{!c.doScriptsLoaded}" /> 
    
    <div class="slds-page-header">
      <div class="slds-media">
        <div class="slds-media__figure">
          <span class="slds-icon_container slds-icon-standard-opportunity" title="Description of icon when needed">
              <img src="{!$Resource.GSALogo}" title="GSA Logo" width="92" height="60" id="GSALogo"/>
          </span>
        </div>
        <div class="slds-media__body">
          <h1 class="slds-page-header__title slds-truncate slds-align-middle" title="Pegasys Data Entry">Pegasys Data Entry</h1>
          <p class="slds-text-body_small slds-line-height_reset">Request Form</p>
        </div>
      </div>
    </div>    
    
    <article class="slds-card">
      <div class="slds-card__header slds-grid">
        <header class="slds-media slds-media_center slds-has-flexi-truncate">
          <div class="slds-media__figure">
            <span class="slds-icon_container slds-icon-standard-contact" title="description of icon when needed">
                <c:svgIcon svgPath="/resource/slds230/assets/icons/utility-sprite/svg/symbols.svg#description" category="utility-sprite" size="small" name="description" />                        
            </span>
          </div>
          <div class="slds-media__body">
            <h2>
              <a href="javascript:void(0);" class="slds-card__header-link slds-truncate" title="[object Object]">
                <span class="slds-text-heading_small">About</span>
              </a>
            </h2>
          </div>
        </header>
        <div class="slds-no-flex hidden">
          <button class="slds-button slds-button_neutral">New</button>
        </div>
      </div>
      <div class="slds-card__body slds-card__body_inner">The Pegasys Data Entry Tool (PDE Tool) is an application used by OCFO - BR to standardize collection and processing of requests for Pegasys Data Entry. The standard form enables automated workflow and document status tracking, increased transparency in the process, prevention of lost or missed documents, workload reporting by document status (i.e. Submitted, Reviewed, Assigned, Issues, Completed), and resource sharing across zones. The following data entry form allows users to submit requests that will be processed by the OCFO<span class="diagnosticLogToggler">.</span></div>
      <footer class="slds-card__footer hidden">Card Footer</footer>
    </article> 
    
    <div style="text-align: center; padding: 10px">    
        <div style="border: 1px solid black; text-align: left; width: 600px; display: inline-block;background-color: #dcdcdc; padding: 5px">
    		<c:PDE_Form />
		    <c:PDE_Attachments />
        </div>
	</div>
    
    <div id="diagnosticLog" class="hidden" style="border:3px solid black; padding:10px; background-color: lightgoldenrodyellow">
        <h2>Diagnostic Log</h2>
        <div id="diagnosticLogMessageStream">
        </div>
    </div>
    
</aura:application>