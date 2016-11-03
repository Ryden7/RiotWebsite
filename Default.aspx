<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent1" Runat="Server">

        <form id="form1" runat="server">

        <ul>
            <li><a href="Webpages/Data/Champdata.aspx">Home</a></li>
        </ul>

            <p>What is your summoner name? </p>
        <asp:TextBox ID="TextBox1" runat="server" CausesValidation="True"></asp:TextBox>
        
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Height="22px" Width="74px"  />

         <asp:ScriptManager ID="ScriptManager2" runat="server"
        EnablePageMethods = "true">
        </asp:ScriptManager>

        <p>What champion is your opponent playing? </p>
             <asp:TextBox ID="txtContactsSearch" runat="server"></asp:TextBox>
        <cc1:AutoCompleteExtender ServiceMethod="GetChampionNames"
            MinimumPrefixLength="1"
            ServicePath="ChampNameService.asmx"
            CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
            TargetControlID="txtContactsSearch"
            ID="AutoCompleteExtender1" runat="server" FirstRowSelected = "false">
        </cc1:AutoCompleteExtender>
 


    
           
           
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        </form>
</asp:Content>


