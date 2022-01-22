<%@ page import="config.Hotel" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="tool.DataBase" %>
<%@ page import="static tool.DataBase.MAP" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("systemadmin") == null) {
        response.sendRedirect("/index.jsp");
    }

//    String sn = request.getSession().getAttribute("systemadmin").toString();
    if(Hotel.status==0){ //modifier l'autorisation
        DataBase.setConnection(MAP.get(Hotel.SYSTEMUSERNAME));
        Hotel.status=1 ;
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <title>Système de gestion hôtel</title>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/semantic.min.css">
    <script src="/semantic/dist/jquery.min.js"></script>
    <script src="/semantic/dist/semantic.js"></script>
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/grid.css">

    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/menu.css">
    <link rel="stylesheet" type="text/css" href="/semantic/dist/components/message.css">

    <style type="text/css">
        h2 {
            margin: 1em 0em;
        }
        .ui.container {
            padding-top: 5em;
            padding-bottom: 5em;
        }
    </style>
    <script>
        var i=0;
        function myDate(){
            var now=new Date();
            var year=now.getFullYear();
            var month=now.getMonth()+1;
            var day=now.getDate();
            var hours=now.getHours();
            var minutes=now.getMinutes();
            var seconds=now.getSeconds();
            document.getElementById("div").innerHTML=year+"annee"+fix(month, 2)+"mois"+fix(day, 2)+"jours"+fix(hours, 2)+" : "+fix(minutes, 2)+" : "+fix(seconds, 2);
        }

        function fix(num, length) {
            return ('' + num).length < length ? ((new Array(length + 1)).join('0') + num).slice(-length) : '' + num;
        }
        setInterval(myDate,1000);
    </script>

<body>
<div class="pusher">
    <div class="ui  inverted menu">
        <a class="item"href="/AdministrationManage?mop=7">
            <i class="sitemap icon"></i>
            Diagramme de l'arborescence de l'administrateur
        </a>
        <div class="ui simple dropdown item">
            <i class="users icon"></i>faire en sorte
            <i class="dropdown icon"></i>
            <div class="menu">
                <a class="item" href="/AdministrationManage?mop=4"><i class="add user icon"></i>Nouvel employé</a>
                <a class="item" href="/AdministrationManage?mop=5"><i class="edit icon"></i>Modifier l'employé</a>
            </div>
        </div>

        <a class="item" href="/AdministrationManage?mop=10">
            <i class="bar chart icon"></i>Statistiques des données commerciales
        </a>

        <div class="right menu">
            <div class="ui simple dropdown item">
                <div id="div"></div>
            </div>
        </div>


        <div class="right menu">
            <div class="ui simple dropdown item">
                <i class="user icon"></i>
                <%="Administrateur du système: " + session.getAttribute("systemadmin")%>

                <i class="dropdown icon"></i>
                <div class="menu">
                    <a class="item" href="/ServiceManage?op=10"><i class="sign out icon"></i>Se déconnecter</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
