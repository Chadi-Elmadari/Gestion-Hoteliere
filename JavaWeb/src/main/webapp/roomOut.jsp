<%@ page import="entity.*" %>
<%@ page import="static tool.Query.getAllRooms" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="static tool.Query.searchFullRooms" %>
<%@ page import="static tool.Query.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Map<String, String[]> map =request.getParameterMap() ;
    int op = Integer.parseInt(map.get("op")[0]) ; 
    Order order =null ;
    if(op==2){
        System.out.println("Numéro de chambre:"+map.get("chadi")[0]);
        order =getOrder(map.get("chadi")[0]) ;
        System.out.println("Numéro de commande:"+order.getOrderNumber());
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
        function returnMainPage() {
            window.location.href="/roomCheckOut.jsp?op=1";
        }
        function fun() {
            var roomid =  document.getElementById("chadi").value ;
            var pat1 = /^[0-9]{6}$/ ;

            if( pat1.test(chadi) ){
                window.location.href="/roomCheckOut.jsp?op=2&roomid="+chadi
            }
            return false ;
        }
    </script>
</head>



<%@include file="/hotelAdmin.jsp"%>
<body>

<div class="pusher">


    <div class="ui container">
        <h2 class="ui header">vérifier</h2>
        <div class="ui column grid">
            <div class="four wide column">
                <div class="ui vertical steps">

                    <div class="<%=(op<=1)?"active step ":"completed step"%>" >
                        <i class="building icon"></i>
                        <div class="content">
                            <div class="title">Sélectionnez le numéro de chambre</div>

                        </div>
                    </div>

                    <div class="<%=(op==2)?"active step ":(op==1)?"step":"completed step"%>">
                        <i class="info icon"></i>
                        <div class="content">
                            <div class="title">Informations sur la commande</div>
                            <%--<div class="description">Enter billing information</div>--%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="eleven wide  column" >

                <%  if(op==1){ %>
                <form class="ui form" onsubmit="return fun(this)">
                    <h4 class="ui dividing header">Sélection de la chambre</h4>
                    <div class="four wide column">
                        <label>Room</label>

                        <div class="five wide field">

                            <select class="ui fluid search dropdown" id="chadi">

                                <%
                                    ArrayList<String> list = searchFullRooms();
                                    if(list.size()==0){
                                %>
                                <option value="Pas de chambre remboursable">Pas de chambre remboursable</option>
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
                    <br/>
                    <div class="ui right submit floated button" tabindex="0" >Submit</div>
                </form>
                <% }
                else if(op==2){%>

                <%--  Numéro de chambre       Temps de séjour  --%>

                <h4 class="ui dividing header">Informations sur la commande</h4>
                <table class="ui table">
                    <thead>
                    <tr><th class="six wide">Name</th>
                        <th class="ten wide">Info</th>
                    </tr></thead>
                    <tbody>

                    <tr>

                        <td>Numéro de commande</td>
                        <td><%=order.getOrderNumber()%></td>

                    </tr>
                    <tr>

                        <td>ID de résident</td>
                        <td><%=order.getCustomerIDCard()%></td>

                    </tr>
                    <tr>

                        <td>Chambre numéro</td>
                        <td><%=order.getRoomNumber()%></td>

                    </tr>
                    <tr>

                        <td>Temps de génération des commandes</td>
                        <td><%=order.getOrderTime()%></td>

                    </tr>
                    <tr>

                        <td>heure d'arrivée</td>
                        <td><%=order.getCheckInTime()%></td>

                    </tr>
                    <tr>

                        <td>heure de départ</td>
                        <td><%=order.getCheckOutTime()%></td>

                    </tr>
                    <tr>

                        <td>Numéro du personnel de service</td>
                        <td><%=order.getWaiterID()%></td>

                    </tr>
                    <tr>

                        <td>Montant total de la commande (y compris le renouvellement)</td>
                        <td><%=order.getTotalMoney()%></td>

                    </tr>
                    <tr>

                        <td>Remarque</td>
                        <td><%=order.getRemarks()%></td>

                    </tr>
                    </tbody>
                </table>


                <h4 class="ui dividing header">Vérification complète</h4>

                <div class="ui right button" >
                    <%--<% if(op==2)System.out.println("Numéro de commande d'impression :"+order.getOrderNumber() );%>--%>
                    <%--<a href="ServiceManage?op=5&orderNumber=<%=order.getOrderNumber()%>">Confirmer le départ</a>--%>
                    <a href="/roomCheckOut.jsp?op=3&orderNumber=<%=order.getOrderNumber()%>">Confirmer le départ</a>
                </div>
                <%}else if (op == 3) {
                    String orderNumber= map.get("orderNumber")[0] ;
                    System.out.println("Commander:"+orderNumber);
                    checkOutRoom(orderNumber) ;
                %>
                <h4 class="ui dividing header">Vérifiez avec succès</h4>
                <div class="ui right button" onclick="returnMainPage()">retourner</div>
                <%}%>
            </div>
            <%--<h1>Bienvenue à renouveler</h1>--%>
            <%--  Numéro de chambre de renouvellement
                        la liste déroulante  
                            Durée de renouvellement et montant du paiement  --%>

</body>
</html>
<script>
    $(document).ready(function () {
        $('.ui.form').form({
                // if( /^[0-9]{6}$/.test(room) && /^[1-9][0-9]?$/.test(time) && /^[0-9]{18}$/.test(idcard)
                //         && /^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenumber) ){
                chadi: {
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
