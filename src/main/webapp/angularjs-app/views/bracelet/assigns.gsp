
<div class="row widget-row">
    <div class="col-md-3" ng-repeat="avaliblecost in avalibleCostsList">
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h6 class="widget-thumb-heading text-capitalize">
                <p class="text-center text-danger">SERIE {{avaliblecost[0].id}}</p>
                {{getNameOfCircuit(avaliblecost[0].circuit.id)}}
                <br>
                Persona: <b class="text-success">{{getNameOfKindPerson(avaliblecost[0].kindPerson.id)}}</b>
                <br>
                Duración: <b class="text-success">{{getNameOfDaysDuration(avaliblecost[0].daysDuration.id)}}</b>
                <br>
                Costo: <b class="text-success">{{avaliblecost[0].cost | currency}}</b>
            </h6>

            <div class="widget-thumb-wrap">
                <div class="widget-thumb-body">
                   <div class="col-md-6">
                       <span class="widget-thumb-subtitle">TOTAL</span>
                       <span class="widget-thumb-body-stat" >{{avaliblecost[1]}}</span>
                   </div>
                   <div class="col-md-6">
                       <span class="widget-thumb-subtitle">Asignadas</span>
                       <span class="widget-thumb-body-stat" >{{avaliblecost[2]}}</span>
                   </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row center">
    <div class="col-md-8 form col-md-offset-2">
        <form role="form">
            <div class="form-body">
                <div class="form-group">
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" placeholder="Escriba un correo o nombres del salesman"
                               ng-model="q" required ng-trim="true" ng-change="getVendedores()" onfocus="true">

                        <span class="input-group-btn">
                            <button class="btn green" type="button">Buscar!</button>
                        </span>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <!-- BEGIN PORTLET-->
        <div class="portlet light bordered ">
            <div class="portlet-title">
                <div class="caption caption-md">
                    <span class="caption-subject bold uppercase">Resultados de la búsqueda</span>
                </div>

                <div class="tools">
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>

            <div class="portlet-body" id="rs-busqueda">
                <div class="note note-danger" ng-show="f1">
                    <h4 class="block">Error para <b>{{salesmanSelected.firstName}} {{salesmanSelected.lastName}}</b></h4>
                    <div class="row" id="response-failed">
                    </div>
                </div>
                <div class="note note-success"  ng-show="f2">
                    <h4 class="block">BIen para <b>{{salesmanSelected.firstName}} {{salesmanSelected.lastName}}</b></h4>
                    <div class="row" id="response-success">
                    </div>
                </div>
                <div class="table-scrollable table-scrollable-borderless">
                    <table class="table table-hover table-light">
                        <thead>
                        <tr class="uppercase">
                            <th colspan="2" class="bold ">Nombres</th>
                            <th class="bold ">Apellidos</th>
                            <th class="bold ">Correo</th>
                            <th class="bold ">NOmbre de Usuario</th>
                            <th class="text-center bold ">Asignar Brazaletes</th>
                        </tr>
                        </thead>
                        <tr ng-repeat="salesman in vendedorList|filter:filtro">
                            <td class="fit">
                                <img class="user-pic rounded"
                                     src="https://cdn3.iconfinder.com/data/icons/line/36/person-24.png"></td>
                            <td>
                                <a href="javascript:;" class="primary-link">{{salesman.firstName}}</a>
                            </td>
                            <td>{{salesman.lastName}}</td>
                            <td>{{salesman.email}}</td>
                            <td>{{salesman.username}}</td>
                            <td class="text-center">
                                <a ng-click="selectSalesman(salesman)" class="btn btn-success" data-toggle="modal" href="#asignar">Asignar</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- END PORTLET-->
    </div>
</div>

<div id="asignar" class="modal fade bs-modal-lg" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog  modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">Seleccione el rango de IDENTIFICADOR de entrega para <b>{{salesmanSelected.firstName}} {{salesmanSelected.lastName}}</b></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="table-scrollable table-scrollable-borderless">
                        <table class="table table-hover table-light">
                            <thead>
                                <th class="font-blue text-uppercase  text-center">
                                    Serie
                                </th>
                                <th class="font-blue text-uppercase  text-center">
                                    inicio
                                </th>
                                <th class="font-blue text-uppercase  text-center">
                                    fin
                                </th>
                                <th class="font-blue text-uppercase  text-center">
                                    total
                                </th>
                            </tr>
                            </thead>
                            <tr ng-repeat="avaliblecost in avalibleCostsList">
                                <td class="text-left">
                                    Serie {{deliveryBraceletResumen[$index].idCost}}
                                </td>
                                <td>
                                    <input type="number" min="1" placeholder="Inicio del rango" class="form-control" ng-model="deliveryBraceletResumen[$index].startRange">
                                </td>
                                <td>
                                    <input type="number" min="1" placeholder="Fin del rango" class="form-control" ng-model="deliveryBraceletResumen[$index].endsRange">
                                </td>
                                <td class="text-center">
                                    <span ng-class=" ( deliveryBraceletResumen[$index].endsRange < deliveryBraceletResumen[$index].startRange )
                                                     || ( deliveryBraceletResumen[$index].endsRange - deliveryBraceletResumen[$index].startRange < 0 )
                                                     ? 'text-danger' : 'text-success'">
                                        {{
                                        (deliveryBraceletResumen[$index].endsRange - deliveryBraceletResumen[$index].startRange) == 0 ?  0 :
                                        deliveryBraceletResumen[$index].endsRange - deliveryBraceletResumen[$index].startRange + 1
                                        }}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    TOTAL
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td class="text-center">
                                    <b>{{getTotal()}}</b>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn red" >Cancelar</button>
                <button type="button" data-dismiss="modal" class="btn green" ng-click="toAssignForSalesman()" ng-show="validate()">
                    Sí, generar
                </button>
            </div>
        </div>
    </div>
</div>