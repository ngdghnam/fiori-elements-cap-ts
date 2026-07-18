sap.ui.define([
  "sap/ovp/cards/custom/Component",
  "sap/ui/model/json/JSONModel"
], function (CardComponent, JSONModel) {
  "use strict";

  return CardComponent.extend("cnma.learningplatform.cnmalearningplatform.ext.customCards.UserInfo.Component", {
    metadata: {
      properties: {
        contentFragment: {
          type: "string",
          defaultValue: "cnma.learningplatform.cnmalearningplatform.ext.customCards.UserInfo.UserInfo"
        },
        headerFragment: {
          type: "string",
          defaultValue: ""
        }
      },
      version: "1.0"
    },

    onAfterRendering: function () {
      var oCard = this.getRootControl();
      var oModel = new JSONModel();
      
      // Fallback data
      oModel.setData({
        fullName: "Loading...",
        email: "",
        avatar: "",
        initials: ""
      });
      oCard.setModel(oModel, "userModel");

      // We can fetch from standard Model
      var oMainModel = this.getModel();
      
      if (oMainModel) {
        var oContext = oMainModel.bindContext("/getUserInfo(...)");
        oContext.setParameter("userId", "current");
        
        oContext.execute().then(function () {
          var oData = oContext.getBoundContext().getObject();
          var initials = "";
          
          if (oData.fullName) {
             var parts = oData.fullName.split(" ");
             if (parts.length > 1) {
               initials = (parts[0][0] + parts[1][0]).toUpperCase();
             } else {
               initials = parts[0][0].toUpperCase();
             }
          } else if (oData.email) {
             initials = oData.email[0].toUpperCase();
          }

          oModel.setData({
            fullName: oData.fullName,
            email: oData.email,
            avatar: oData.avatar,
            initials: initials
          });
        }).catch(function(oError) {
          console.error("Error fetching user info:", oError);
          oModel.setData({
            fullName: "Error",
            email: "Could not load user profile",
            avatar: "",
            initials: "!"
          });
        });
      }
    }
  });
});
