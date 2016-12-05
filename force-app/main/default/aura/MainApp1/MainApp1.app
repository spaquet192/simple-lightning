<aura:application extends="force:slds">
    
    <!-- declare attributes -->
    
    <!-- declare events -->
	<aura:handler event="aura:waiting"
                  action="{!c.showSpinner}"/>
    <aura:handler event="aura:doneWaiting"
                  action="{!c.hideSpinner}"/>    
    
    <!-- declare dependencies -->
    <aura:dependency resource="markup://c:ModalDialog" />
    
    <!-- Progress spinner -->
    <div aura:id="spinner"
         class="slds-align--absolute-center slds-hide">
        <lightning:spinner variant="brand" size="large"/>
    </div>
    
    <!-- Sample component reuse: ModalDialog -->
    <c:ModalDialog aura:id="welcomeModal" Title="My Task List App"
                   cancelLabel="">
    	Welcome to the Task List app where you can manage 
        your tasks at Lightning speed !
    </c:ModalDialog>
    
    <!-- Main app markup body -->
    <div aura:id="mainApp">
    	<lightning:tabset >
        	<lightning:tab label="Tasks"
                           title="My Tasks">
                <c:TaskList >
                	Here are my tasks for today...
                </c:TaskList>
            </lightning:tab>
        	<lightning:tab label="Details"
                           title="Task detail record">
                <force:recordView recordId="00T4100000AcxwtEAB"/>
            </lightning:tab>
        </lightning:tabset>
    </div>
	
</aura:application>