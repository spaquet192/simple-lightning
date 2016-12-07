<aura:application >
    <aura:attribute name="Name" type="String"/>
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <aura:if isTrue="{!v.Name == ''}">
        <c:NewComponent aura:id="defaultComp"/>
    <aura:set attribute="else">
        <c:NewComponent Name="{!v.Name}"/>
    </aura:set>
  </aura:if> 
</aura:application>