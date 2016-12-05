<aura:application extends="force:slds">
    <aura:attribute name="title" type="String" default="My Task List"/>
	<aura:handler event="aura:waiting"
                  action="{!c.showSpinner}"/>
    <aura:handler event="aura:doneWaiting"
                  action="{!c.hideSpinner}"/>      
        <!-- Progress spinner -->
    <div aura:id="spinner"
         class="slds-align--absolute-center slds-hide">
        <lightning:spinner variant="brand" size="large"/>
    </div>
    <c:Card header="{!v.title}"
            action="Create New"
            footer="(c) SimpleApps.com">
    	<c:TaskListSimple />
    </c:Card>
</aura:application>