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
        oMainModel.callFunction("/getUserInfo", {
          method: "GET",
          urlParameters: { userId: "'current'" },
          success: function(oData) {
            var result = oData.getUserInfo || oData.results || oData;
            var initials = "";
            
            if (result.fullName) {
               var parts = result.fullName.split(" ");
               if (parts.length > 1) {
                 initials = (parts[0][0] + parts[1][0]).toUpperCase();
               } else {
                 initials = parts[0][0].toUpperCase();
               }
            } else if (result.email) {
               initials = result.email[0].toUpperCase();
            }

            oModel.setData({
              fullName: result.fullName,
              email: result.email,
              avatar: result.avatar,
              initials: initials
            });
          },
          error: function(oError) {
            console.error("Error fetching user info:", oError);
            oModel.setData({
              fullName: "Error",
              email: "Could not load user profile",
              avatar: "",
              initials: "!"
            });
          }
        });
      }
    }
  });
});
