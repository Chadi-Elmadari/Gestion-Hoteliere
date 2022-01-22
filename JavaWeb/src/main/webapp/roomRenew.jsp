<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullRooms" %>
<%@ page import="static tool.Query.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ;
    TimeExtension renew=null ;
    if(op==2){
        
        
        Order order = getOrder(map.get("chadi")[0]);
        String orderid =order.getOrderNumber() ;       
        Date olddate = order.getCheckOutTime();
        Date newdate = order.getCheckOutTime();
        Calendar calendar =Calendar.getInstance();
        calendar.setTime(newdate);
        System.out.println(Integer.parseInt(map.get("time")[0]) );
        calendar.add(5, Integer.parseInt(map.get("time")[0]));
        
        newdate = new Date(calendar.getTime().getTime()) ;
        //Prix ​​calculé = prix unitaire * remise * jours ;
        double discount = searchDiscount(order.getCustomerIDCard());

        int price = 1  ;
        renew=new TimeExtension(getRenewNum()+1,orderid,olddate,newdate,(int)(discount*Integer.parseInt(map.get("time")[0])
                *getRoomPrice(order.getRoomNumber()))) ;
        request.getSession().setAttribute("renew",renew);

    }

%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Système de gestion d'hôtel</title>
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

    <script >

        function fun1() {

            alert("Renouvellement réussi,retour à la page d'accueil!")
            window.location.href="/ServiceManage?op=4";
        }

        function fun2() {

            var roomid = document.getElementById("chadi").value
            var time = document.getElementById("time").value
            var pat1 = /^[0-9]{6}$/ ;
            var pat2 =/^[1-9][0-9]?$/ ;

            if(pat1.test(roomid) && pat2.test(time)){
                window.location.href="/roomRenew.jsp?op=2&chadi="+chadi+"&time="+time
            }
            return false
        }

    </script>
</head>

<%@include file="/hotelAdmin.jsp"%>


<body>

<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">Renouvellement de la chambre</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">Sélectionnez le numéro de chambre</div>
                            <%--<div class="description">Choose your shipping options</div>--%>
                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">chadi</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun2(this)">
                    <h4 class="ui dividing header">Sélection de la chambre</h4>
                    <div class="four wide column">
                        <label>Room</label>


                        <div class="five wide field">


                            <select class="ui fluid search dropdown" id="chadi" name="chadi">

                                <%
                                    ArrayList<String> list = searchFullRooms();
                                    if(list.size()==0){
                                %>
                                <option value="Pas de place pour continuer">Pas de place pour continuer</option>
                                <%
                                    }
                                    for(String str : list){
                                %>
                                <option value=<%=str%>> <%=str%> </option>
                                <% } %>
                            </select>
                            <%--<input type="text" name="chadi" placeholder="Enregistré">--%>
                        </div>
                    </div>
                    <h4 class="ui dividing header">Temps de renouvellement</h4>
                    <div class="eight wide field">
                        <label>Time</label>
                        <div class=" fields">
                            <div class="eight wide field">

                                <input type="text" maxlength="8"  placeholder="time" id="time" name="time">
                            </div>
                        </div>

                    </div>
                    <br/>
                    <div class="ui right submit floated button" tabindex="0" >Submit Order</div>
                </form>
                <% } else if(op==2){ %>


                <h4 class="ui dividing header">Confirmation de commande</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>
                    <tr>
                        <td>Numéro de commande de renouvellement</td>
                        <td><%=renew.getOperatingID() %></td>
                    </tr>
                    <tr>
                        <td>Numéro de commande d'origine</td>
                        <td><%=renew.getOrderNumber() %></td>
                    </tr>
                    <tr>
                        <td>Date d'expiration d'origine</td>
                        <td><%=renew.getOldExpiryDate() %></td>
                    </tr>
                    <tr>
                        <td>Montant du paiement</td>
                        <td><%=renew.getAddedMoney() %></td>
                    </tr>
                    <tr>
                        <td>Heure d'expiration actuelle</td>
                        <td><%=renew.getNewExpiryDate() %></td>
                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">Paiement complet</h4>
                <div class="ui right floated labeled button" tabindex="0">
                    <a class="ui basic right pointing label">
                        <%-- Allez dans la base de données pour interroger le prix * le nombre de jours * la remise correspondante --%>
                        ¥<%=renew.getAddedMoney() %>
                    </a>
                    <div class="ui right button" onclick="fun1()">
                        <i class="shopping icon"></i> Payer
                    </div>
                </div>
                <%}%>

            </div>
            <%--<h1>Bienvenue à renouveler</h1>--%>
            <%--  Numéro de chambre de renouvellement * liste déroulante * durée de renouvellement * montant du paiement * le renouvellement doit modifier la date de départ du bon de commande correspondant --%>

</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(room) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumber) ){
                time: {
                    identifier: 'time',
                    rules: [
                        {
                            type: 'regExp[/^[1-9][0-9]?$/]',
                            prompt: 'Le temps est pas à la hauteur des spécifications'
                        }
                    ]
                }
                ,chadi: {
                    identifier: 'chadi',
                    rules: [
                        {
                            type: 'regExp[/^[0-9]{6}$/]',
                            prompt: 'Le numéro de chambre ne correspond pas aux spécifications'
                        }
                    ]
                }

            }, {

                inline : true,
                on     : 'submit'

            }
        )

        ;
    });
</script>
