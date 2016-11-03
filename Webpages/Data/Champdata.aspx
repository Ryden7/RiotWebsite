<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" CodeFile="Champdata.aspx.cs" Inherits="Champdata" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent1" Runat="Server" style="display:inline-block">
   <strong><% =FirstName %>  - <%=Championstats.Attackrange %> </strong>    <span style="float:right"><strong><% =opponentChamp %> - <%=Championstats2.Attackrange %></strong> </span>
    <br />
    <br />

    
    <span style="float:left"><strong> <%=Championstats.HP %>   + <%=Championstats.HPlvl %> </strong> </span>   <span style="float:right"><strong><% =Championstats2.HP %> + <%=Championstats2.HPlvl %></strong> </span>
        <br />
    <br />
   <span style="float:left"><strong> <%=Championstats.Movespeed %>  </strong> </span>  <span style="float:right"><strong><% =Championstats2.Movespeed %> </strong> </span>

        <br />
    <br />
    <span style="float:left"><strong> <%=Championstats.Attackdamage %>  + <%=Championstats.Attackdamagelvl %> </strong> </span>  <span style="float:right"><strong><% =Championstats2.Attackdamage %> + <%=Championstats2.Attackdamagelvl %></strong> </span>

        <br />
    <br />
  <span style="float:left"><strong> <%=Championstats.Armor %>   + <%=Championstats.Armorlvl %>  </strong> </span>    <span style="float:right"><strong><% =Championstats2.Armor %> + <%=Championstats2.Armorlvl %></strong> </span>
        <br />
    <br />
    <span style="float:left"><strong> <%=Championstats.MagicResist %>  + <%=Championstats.MagicResistperlvl %> </strong> </span>     <span style="float:right"><strong><% =Championstats2.MagicResist %> + <%=Championstats2.MagicResistperlvl %></strong> </span>








</asp:Content>

