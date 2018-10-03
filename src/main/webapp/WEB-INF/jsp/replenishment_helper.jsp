<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link th:href="@{/css/kendo.common-bootstrap.min.css}" href="../../../resources/static/css/kendo.common-bootstrap.min.css" rel="stylesheet">
    <link th:href="@{/css/kendo.bootstrap-v4.min.css}" href="../../../resources/static/css/kendo.bootstrap-v4.min.css" rel="stylesheet">
    <link th:href="@{/css/bootstrap.min.css}" href="../../../resources/static/css/bootstrap.min.css" rel="stylesheet">
    <script th:src="@{/js/jquery.min.js}" src="../../../resources/static/js/jquery.min.js"></script>
    <script th:src="@{/js/kendo.all.min.js}" src="../../../resources/static/js/kendo.all.min.js"></script>
    <script th:src="@{/js/bootstrap.bundle.min.js}" src="../../../resources/static/js/bootstrap.bundle.min.js"></script>
    <title>补单辅助查询</title>
    <style>
        html,
        body {
            background: #ECF0F5;
            font-size: 14px;
            font-family: '微软雅黑', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            /* font-weight: 600 */
        }

        #qiGrid .k-grid-content,
        #qiQualityGrid .k-grid-content,
        #dyeGrid .k-grid-content,
        #dyeQualityGrid .k-grid-content,
        #storeGrid .k-grid-content,
        #storeQualityGrid .k-grid-content,
        #packGrid .k-grid-content,
        #packQualityGrid .k-grid-content,
        #tdcShrinkageGrid .k-grid-content,
        #widthOverGrid .k-grid-content {
            min-height: 100px;
            max-height: 420px;
        }

        #gekOverShortRatioDetailTopGrid .k-grid-content,
        #gekOverShortRatioDetailBottomGrid .k-grid-content {
            min-height: 100px;
            max-height: 250px;
        }

        .modal-lg {
            max-width: 95%;
        }
    </style>
</head>

<body>
<!-- <div class="mb-2 p-2 bg-info text-center text-white shadow-sm" style="font-weight: bold; font-size: 22px; letter-spacing: 5px;">
  补单辅助查询系统
</div> -->

<div class="container-fluid mt-2">
    <div class="row mb-2 bg-light p-3 shadow-sm">
        <div class="col-3">
            成品品名：
            <input class="w-75" id="gknum" style="border-color: transparent; height: 2.2rem" type="text"
                   oninput="getJobnum(event.target.value.trim())">

        </div>
        <div class="col-3">
            排单号：
            <input class="w-75" id="jobnum" type="text">

        </div>
        <!-- <div class="col-3">
          订单号：
          <input class="w-75" id="pponum" type="text">

        </div> -->
        <div class="col-3">
            <button class="btn btn-primary" type="button" onclick="search()">查询</button>
        </div>
    </div>

    <div class="mb-2 bg-light p-3 shadow-sm">
        <div class="row">
            <div class="col-6">
                <div class="row mb-3 no-gutters">
                    <div class="col-3">
                        GEK实际溢短%:
                    </div>
                    <div class="col-9">
                        <input class="w-100 k-textbox" id="gekOverShortRatio" type="text" readonly>
                    </div>

                </div>

                <div class="row mb-3 no-gutters">
                    <div class="col-3">
                        成衣要求溢短%:
                    </div>
                    <div class="col-4">
                        <input class="w-100" id="pponum" type="text">
                    </div>
                    <div class="col-5 pl-1">
                        <input class="w-100 k-textbox" id="gmtOverShortRatio" type="text" readonly>
                    </div>

                </div>

                <div class="row mb-3 no-gutters">
                    <div class="col-3">
                        工艺要求缩水:
                    </div>
                    <div class="col-9">
                        <input class="w-100 k-textbox" id="artShrinkage" type="text" readonly>
                    </div>

                </div>

            </div>

            <div class="col-6">

                <div class="row mb-3">
                    <div class="col-3 text-right">
                        让码码数:
                    </div>
                    <div class="col-7">
                        <input class="w-100 k-textbox" id="allowQty" type="text" readonly>
                    </div>
                    <div class="col-2">
                        <button class="btn btn-sm btn-success" type="button" data-toggle="modal"
                                data-target="#gekOverShortRatioDetail">装单详情
                        </button>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-3 text-right">
                        门幅偏大比例:
                    </div>
                    <div class="col-7">
                        <input class="w-100 k-textbox" id="widthOver" type="text" readonly>
                    </div>
                    <div class="col-2">
                        <button class="btn btn-sm btn-success" type="button" data-toggle="modal"
                                data-target="#widthOverDetail">布号详情
                        </button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-3 text-right">
                        TDC缩水结果:
                    </div>
                    <div class="col-7">
                        <input class="w-100 k-textbox" id="tdcShrinkage" type="text" readonly>
                    </div>
                    <div class="col-2">
                        <button class="btn btn-sm btn-success" type="button" data-toggle="modal"
                                data-target="#tdcShrinkageDetail">缩水详情
                        </button>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <div class="position-absolute" style="z-index: 999; right: 50px">
        <button class="btn btn-sm btn-primary" onclick="adjustColumnWidthTotal()">调整列宽</button>
    </div>
    <div id="tabstrip" class="shadow-sm">
        <ul>
            <li class="k-state-active">相同品名</li>
            <li>相同质量</li>
        </ul>
        <div>
            <div class="accordion" id="accordionExample">
                <div class="card mb-2">
                    <div class="card-header" id="headingOne">
                        <h6 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseOne"
                                    aria-expanded="true" aria-controls="collapseOne">
                                <span class="k-icon k-i-minus"></span>
                                染整
                            </button>
                        </h6>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="">
                        <div class="card-body">
                            <div id="dyeGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card mb-2">
                    <div class="card-header" id="headingTwo">
                        <h6 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseTwo"
                                    aria-expanded="true" aria-controls="collapseTwo">
                                <span class="k-icon k-i-minus"></span>
                                QI
                            </button>
                        </h6>
                    </div>
                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="">
                        <div class="card-body">
                            <div id="qiGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseThree"
                                    aria-expanded="true" aria-controls="collapseThree">
                                <span class="k-icon k-i-minus"></span>
                                库存
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse show" aria-labelledby="headingThree" data-parent="">
                        <div class="card-body">
                            <div id="storeGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingFour">
                        <h5 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseFour"
                                    aria-expanded="true" aria-controls="collapseFour">
                                <span class="k-icon k-i-minus"></span>
                                装单
                            </button>
                        </h5>
                    </div>
                    <div id="collapseFour" class="collapse show" aria-labelledby="headingFour" data-parent="">
                        <div class="card-body">
                            <div id="packGrid"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <div class="accordion" id="accordionExample">
                <div class="card mb-2">
                    <div class="card-header" id="headingOne">
                        <h6 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseOne"
                                    aria-expanded="true" aria-controls="collapseOne">
                                <span class="k-icon k-i-minus"></span>
                                染整
                            </button>
                        </h6>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="">
                        <div class="card-body">
                            <div id="dyeQualityGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card mb-2">
                    <div class="card-header" id="headingTwo">
                        <h6 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseTwo"
                                    aria-expanded="true" aria-controls="collapseTwo">
                                <span class="k-icon k-i-minus"></span>
                                QI
                            </button>
                        </h6>
                    </div>
                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="">
                        <div class="card-body">
                            <div id="qiQualityGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseThree"
                                    aria-expanded="true" aria-controls="collapseThree">
                                <span class="k-icon k-i-minus"></span>
                                库存
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse show" aria-labelledby="headingThree" data-parent="">
                        <div class="card-body">
                            <div id="storeQualityGrid"></div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingFour">
                        <h5 class="mb-0">
                            <button class="btn btn-sm btn-success" type="button" data-toggle="collapse"
                                    data-target="#collapseFour"
                                    aria-expanded="true" aria-controls="collapseFour">
                                <span class="k-icon k-i-minus"></span>
                                装单
                            </button>
                        </h5>
                    </div>
                    <div id="collapseFour" class="collapse show" aria-labelledby="headingFour" data-parent="">
                        <div class="card-body">
                            <div id="packQualityGrid"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


</div>


<!-- Modal -->
<div class="modal fade" id="gekOverShortRatioDetail" tabindex="-1" role="dialog"
     aria-labelledby="gekOverShortRatioDetailTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content rounded shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="gekOverShortRatioDetailTitle">装单信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <div class="mb-2">
                        成品布身订单信息
                        <button class="btn btn-sm btn-primary float-right"
                                onclick="adjustColumnWidthSingle(gekOverShortRatioDetailTopGrid)">调整列宽
                        </button>
                    </div>
                    <div id="gekOverShortRatioDetailTopGrid"></div>

                    <div class="mt-2 mb-2">
                        成品布身装单明细
                        <button class="btn btn-sm btn-primary float-right"
                                onclick="adjustColumnWidthSingle(gekOverShortRatioDetailBottomGrid)">调整列宽
                        </button>
                    </div>
                    <div id="gekOverShortRatioDetailBottomGrid"></div>
                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div> -->
        </div>
    </div>
</div>

<div class="modal fade" id="widthOverDetail" tabindex="-1" role="dialog" aria-labelledby="widthOverDetailTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content rounded shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="widthOverDetailTitle">布号信息详情</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <div class="mb-2">
                        &nbsp;
                        <button class="btn btn-sm btn-primary float-right"
                                onclick="adjustColumnWidthSingle(widthOverGrid)">调整列宽
                        </button>
                    </div>
                    <div id="widthOverGrid"></div>


                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div> -->
        </div>
    </div>
</div>

<div class="modal fade" id="tdcShrinkageDetail" tabindex="-1" role="dialog" aria-labelledby="tdcShrinkageDetailTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content rounded shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="tdcShrinkageDetailTitle">TDC缩水结果明细</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <div class="mb-2">
                        明细
                        <button class="btn btn-sm btn-primary float-right"
                                onclick="adjustColumnWidthSingle(tdcShrinkageGrid)">调整列宽
                        </button>
                    </div>
                    <div id="tdcShrinkageGrid"></div>


                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div> -->
        </div>
    </div>
</div>

<div class="modal fade" id="packDetail" tabindex="-1" role="dialog" aria-labelledby="packDetailTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content rounded shadow">
            <div class="modal-header">
                <h5 class="modal-title" id="packDetailTitle">TDC缩水结果明细</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <div class="mb-2">
                        明细
                        <button class="btn btn-sm btn-primary float-right"
                                onclick="adjustColumnWidthSingle(packDetailGrid)">调整列宽
                        </button>
                    </div>
                    <div id="packDetailGrid"></div>


                </div>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div> -->
        </div>
    </div>
</div>

<script>
    var dyeGrid;
    var dyeQualityGrid;
    var qiGrid;
    var qiQualityGrid;
    var storeGrid;
    var storeQualityGrid;
    var packGrid;
    var packDetailGrid;
    var packQualityGrid;
    var gekOverShortRatioDetailTopGrid;
    var gekOverShortRatioDetailBottomGrid;
    var widthOverGrid;
    var tdcShrinkageGrid;
    var tabstrip;
    var jobnum;
    var pponum;

    $(document).ready(function () {
        jobnum = $("#jobnum").kendoComboBox({
            dataTextField: "Job_No",
            dataValueField: "Job_No",
            fiter: true,
            change: function (e) {
                var value = this.value();
                kendo.ui.progress($(document.body), true);
                pponum.text('');
                $.ajax({
                    url: getApiUrl() + '/search_pponum?gknum=' + $('#gknum').val().trim() + '&jobnum=' + $('#jobnum').val(),
                    method: 'GET',
                    success: function (res) {
                        pponum.setDataSource(new kendo.data.DataSource({
                            data: res
                        }))
                        pponum.select(0)
                        kendo.ui.progress($(document.body), false);
                    },
                    error: function (err) {
                        kendo.ui.progress($(document.body), false);
                        console.log(err)
                    }

                })
            }
        }).data('kendoComboBox');

        pponum = $("#pponum").kendoComboBox({
            dataTextField: "PPO_No",
            dataValueField: "PPO_No",
            fiter: true
        }).data('kendoComboBox');

        tabstrip = $("#tabstrip").kendoTabStrip({}).data('kendoTabStrip');

        dyeGrid = $("#dyeGrid").kendoGrid({
            // height: '200px',
            filterable: true,
            sortable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "缸号", title: "缸号", width: "100px"},
                {field: "缸状态", title: "缸状态", width: "120px"},
                {field: "排单号", title: "排单号", width: "110px"},
                {field: "品名", title: "品名", width: "190px"},
                {field: "机型", title: "机型", width: "100px"},
                {field: "纱批", title: "纱批", width: "250px"},
                {field: "用途", title: "用途", width: "80px"},
                {field: "色号", title: "色号", width: "300px"},
                {field: "颜色", title: "颜色", width: "270px"},
                {field: "ComboID", title: "ComboID", width: "110px"},
                {field: "要求重量", title: "要求重量", width: "120px"},
                {field: "发布重量", title: "发布重量", width: "120px"},
                {field: "实际重量", title: "实际重量", width: "120px"},
                {field: "当前工序", title: "当前工序", width: "120px"},
                {field: "工序时间", title: "工序时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "发布时间", title: "发布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "备布时间", title: "备布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "逢边时间", title: "逢边时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "投染时间", title: "投染时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "内对色时间", title: "内对色时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "内对色结果", title: "内对色结果", width: "120px"},
                {field: "BF时间", title: "BF时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "BF结果", title: "BF结果", width: "120px"},
                {field: "烘干时间", title: "烘干时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "中检时间", title: "中检时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "中检结果", title: "中检结果", width: "120px"},
                {field: "丝光时间", title: "丝光时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "抓磨毛时间", title: "抓磨毛时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "预缩时间", title: "预缩时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "定型时间", title: "定型时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "AF时间", title: "AF时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "AF结果", title: "AF结果", width: "120px"},

            ],
            dataBound: function (e) {
                var grid = this;
                $("#dyeGrid .k-grouping-row").each(function (e) {
                    grid.collapseGroup(this);
                });
            }
        }).data('kendoGrid');

        dyeQualityGrid = $("#dyeQualityGrid").kendoGrid({
            // height: '200px',
            filterable: true,
            sortable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "缸号", title: "缸号", width: "100px"},
                {field: "缸状态", title: "缸状态", width: "120px"},
                {field: "排单号", title: "排单号", width: "110px"},
                {field: "品名", title: "品名", width: "190px"},
                {field: "机型", title: "机型", width: "100px"},
                {field: "纱批", title: "纱批", width: "250px"},
                {field: "用途", title: "用途", width: "80px"},
                {field: "色号", title: "色号", width: "300px"},
                {field: "颜色", title: "颜色", width: "270px"},
                {field: "ComboID", title: "ComboID", width: "110px"},
                {field: "要求重量", title: "要求重量", width: "120px"},
                {field: "发布重量", title: "发布重量", width: "120px"},
                {field: "实际重量", title: "实际重量", width: "120px"},
                {field: "当前工序", title: "当前工序", width: "120px"},
                {field: "工序时间", title: "工序时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "发布时间", title: "发布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "备布时间", title: "备布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "逢边时间", title: "逢边时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "投染时间", title: "投染时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "内对色时间", title: "内对色时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "内对色结果", title: "内对色结果", width: "120px"},
                {field: "BF时间", title: "BF时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "BF结果", title: "BF结果", width: "120px"},
                {field: "烘干时间", title: "烘干时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "中检时间", title: "中检时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "中检结果", title: "中检结果", width: "120px"},
                {field: "丝光时间", title: "丝光时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "抓磨毛时间", title: "抓磨毛时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "预缩时间", title: "预缩时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "定型时间", title: "定型时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "AF时间", title: "AF时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "AF结果", title: "AF结果", width: "120px"},

            ],
            dataBound: function (e) {
                var grid = this;
                $("#dyeQualityGrid .k-grouping-row").each(function (e) {
                    grid.collapseGroup(this);
                });
            }
        }).data('kendoGrid');

        qiGrid = $("#qiGrid").kendoGrid({
            // height: '400px',
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            // pageable: true,
            columns: [
                {field: "source", title: "来源", width: "80px"},
                {field: "Processname", title: "工序", width: "150px"},
                {field: "PPOString", title: "订单明细", width: "180px"},
                {field: "GK_NO", title: "品名", width: "190px"},
                {field: "Batch_No", title: "缸号", width: "100px"},
                {field: "Car_String", title: "车牌明细", width: "120px"},
                {field: "Fabric_NO", title: "布号", width: "130px"},
                {field: "Weight", title: "重量", width: "100px"},
                {field: "quantity", title: "数量", width: "100px"},
                {field: "In_Time", title: "收布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "QC_Time", title: "QC时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Inspect_Time", title: "验布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Destination", title: "交地", width: "90px"},
                {field: "Delivery_Date", title: "交期", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Hold", title: "状态", width: "80px"},

                // { field: "Job_No", title: "排单号" },
                // { field: "Rest_Time", title: "Rest_Time" },
            ],

        }).data('kendoGrid');

        qiQualityGrid = $("#qiQualityGrid").kendoGrid({
            // height: '400px',
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            // pageable: true,
            columns: [
                {field: "source", title: "来源", width: "80px"},
                {field: "Processname", title: "工序", width: "150px"},
                {field: "PPOString", title: "订单明细", width: "180px"},
                {field: "GK_NO", title: "品名", width: "190px"},
                {field: "Batch_No", title: "缸号", width: "100px"},
                {field: "Car_String", title: "车牌明细", width: "120px"},
                {field: "Fabric_NO", title: "布号", width: "130px"},
                {field: "Weight", title: "重量", width: "100px"},
                {field: "quantity", title: "数量", width: "100px"},
                {field: "In_Time", title: "收布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "QC_Time", title: "QC时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Inspect_Time", title: "验布时间", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Destination", title: "交地", width: "90px"},
                {field: "Delivery_Date", title: "交期", format: "{0: yyyy-MM-dd HH:mm:ss}", width: "180px"},
                {field: "Hold", title: "状态", width: "80px"},

                // { field: "Job_No", title: "排单号" },
                // { field: "Rest_Time", title: "Rest_Time" },
            ],

        }).data('kendoGrid');

        storeGrid = $("#storeGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "品名", title: "品名", width: "160px"},
                {field: "缸号", title: "缸号", width: "120px"},
                {field: "颜色", title: "颜色", width: "270px"},
                {field: "工厂", title: "工厂", width: "80px"},
                {field: "仓库", title: "仓库", width: "160px"},
                {field: "可用码长", title: "码长", width: "90px"},
                {field: "订单", title: "订单", width: "180px"},
                {field: "客户", title: "客户", width: "180px"},
                {field: "用途", title: "用途", width: "80px"},
            ],

        }).data('kendoGrid');

        storeQualityGrid = $("#storeQualityGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "品名", title: "品名", width: "160px"},
                {field: "缸号", title: "缸号", width: "120px"},
                {field: "颜色", title: "颜色", width: "270px"},
                {field: "工厂", title: "工厂", width: "80px"},
                {field: "仓库", title: "仓库", width: "160px"},
                {field: "可用码长", title: "码长", width: "90px"},
                {field: "订单", title: "订单", width: "180px"},
                {field: "客户", title: "客户", width: "180px"},
                {field: "用途", title: "用途", width: "80px"},
            ],
        }).data('kendoGrid');

        packGrid = $("#packGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "allowance_level", title: "客户分类", width: "100px"},
                {field: "PPO_No", title: "订单号", width: "180px"},
                {field: "Usage", title: "布类", width: "80px"},
                {field: "GK_No", title: "品名", width: "180px"},
                {field: "Job_No", title: "排单号", width: "120px"},
                {field: "Lot_NO", title: "批次", width: "80px"},
                {field: "payMent", title: "付款方式", width: "120px"},
                {field: "Lot_Type", title: "批次类型", width: "120px"},
                {field: "Lot_Status", title: "批次状态", width: "120px"},
                {field: "Quantity", title: "要求数", width: "100px"},
                {field: "Packed_Qty", title: "装单数", width: "100px"},
                {field: "Delivery_Qty", title: "欠数", width: "100px"},
                {field: "Destination", title: "交地", width: "100px"},
                {field: "Delivery_Date", title: "QI交期", format: "{0: yyyy-MM-dd}", width: "120px"},
                {field: "MakeOrderRatio", title: "参考比例", width: "120px"},
                {field: "Over_Ship", title: "溢装比例", width: "120px"},
                {field: "Short_Ship", title: "短装比例", width: "120px"},
                {field: "Print_Prec", title: "所占比例", width: "120px"},
                {field: "IS_Deliveried", title: "是否已出货完", width: "160px"},
                {field: "Combo", title: "颜色", width: "300px"},
                {field: "color_code", title: "色号", width: "300px"},
                {field: "Customer", title: "客户", width: "300px"},
                {field: "PPO_Lot_ID", title: "批次序号", width: "120px"},
            ],
            dataBound: function () {
                var grid = this;

                grid.element.on('dblclick', 'tbody tr[data-uid]', function (e) {
                    kendo.ui.progress($(document.body), true);
                    var selectedRows = grid.select();
                    var dataItem = grid.dataItem(selectedRows[0]);
                    $.ajax({
                        url: getApiUrl() + '/search_pack_detail/' + dataItem.PPO_Lot_ID,
                        method: 'GET',
                        success: function (res) {
                            packDetailGrid.setDataSource(new kendo.data.DataSource({
                                data: res
                            }))
                            $('#packDetail').modal('show')
                            kendo.ui.progress($(document.body), false);
                        },
                        error: function (err) {
                            kendo.ui.progress($(document.body), false);
                            console.log(err)
                        }

                    })

                })
            }
        }).data('kendoGrid');

        packQualityGrid = $("#packQualityGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "allowance_level", title: "客户分类", width: "100px"},
                {field: "PPO_No", title: "订单号", width: "180px"},
                {field: "Usage", title: "布类", width: "80px"},
                {field: "GK_No", title: "品名", width: "180px"},
                {field: "Job_No", title: "排单号", width: "120px"},
                {field: "Lot_NO", title: "批次", width: "80px"},
                {field: "payMent", title: "付款方式", width: "120px"},
                {field: "Lot_Type", title: "批次类型", width: "120px"},
                {field: "Lot_Status", title: "批次状态", width: "120px"},
                {field: "Quantity", title: "要求数", width: "100px"},
                {field: "Packed_Qty", title: "装单数", width: "100px"},
                {field: "Delivery_Qty", title: "欠数", width: "100px"},
                {field: "Destination", title: "交地", width: "100px"},
                {field: "Delivery_Date", title: "QI交期", format: "{0: yyyy-MM-dd}", width: "120px"},
                {field: "MakeOrderRatio", title: "参考比例", width: "120px"},
                {field: "Over_Ship", title: "溢装比例", width: "120px"},
                {field: "Short_Ship", title: "短装比例", width: "120px"},
                {field: "Print_Prec", title: "所占比例", width: "120px"},
                {field: "IS_Deliveried", title: "是否已出货完", width: "160px"},
                {field: "Combo", title: "颜色", width: "300px"},
                {field: "color_code", title: "色号", width: "300px"},
                {field: "Customer", title: "客户", width: "300px"},
                {field: "PPO_Lot_ID", title: "批次序号", width: "120px"},
            ],
            dataBound: function () {
                var grid = this;

                grid.element.on('dblclick', 'tbody tr[data-uid]', function (e) {
                    kendo.ui.progress($(document.body), true);
                    var selectedRows = grid.select();
                    var dataItem = grid.dataItem(selectedRows[0]);
                    $.ajax({
                        url: getApiUrl() + '/search_pack_detail/' + dataItem.PPO_Lot_ID,
                        method: 'GET',
                        success: function (res) {
                            packDetailGrid.setDataSource(new kendo.data.DataSource({
                                data: res
                            }))
                            $('#packDetail').modal('show')
                            kendo.ui.progress($(document.body), false);
                        },
                        error: function (err) {
                            kendo.ui.progress($(document.body), false);
                            console.log(err)
                        }

                    })

                })
            }
        }).data('kendoGrid');

        packDetailGrid = $("#packDetailGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "Batch_NO", title: "缸号", width: "180px"},
                {field: "GK_NO", title: "品名", width: "180px"},
                {field: "Job_NO", title: "排单号", width: "180px"},
                {field: "Fabric_NO", title: "布号", width: "180px"},
                {field: "Circle", title: "循环数", width: "180px"},
                {field: "Grade", title: "等级", width: "180px"},
                {field: "OZYD", title: "码重", width: "180px"},
                {field: "Shade", title: "色级", width: "180px"},
                {field: "Quantity", title: "码长", width: "180px"},
                {field: "Allow_Quantity", title: "送码", width: "180px"},
                {field: "FOC_Quantity", title: "FOC长", width: "180px"},
                {field: "Laste_Quantity", title: "装单码长", width: "180px"},
                {field: "Weight", title: "重量", width: "180px"},
                {field: "Allow_Weight", title: "送码重", width: "180px"},
                {field: "FOC_Weight", title: "FOC重", width: "180px"},
                {field: "Laste_Weight", title: "装单重量", width: "180px"},
                {field: "DN_Type", title: "出货类型", width: "180px"},
                {field: "DN_Department", title: "装单部门", width: "180px"},
                {field: "Status", title: "装单状态", width: "180px"},
                {field: "百平方码分", title: "百平方码分", width: "180px"},
                {field: "让码疵点分", title: "让码疵点分", width: "180px"},
                {field: "主要疵点名", title: "主要疵点名", width: "180px"},
                {field: "总疵点分", title: "总疵点分", width: "180px"},

            ]
        }).data('kendoGrid');

        gekOverShortRatioDetailTopGrid = $("#gekOverShortRatioDetailTopGrid").kendoGrid({
            selectable: 'row',
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "allowance_level", title: "客户分类", width: "80px"},
                {field: "PPO_No", title: "订单号", width: "180px"},
                {field: "Usage", title: "布类", width: "80px"},
                {field: "GK_No", title: "品名", width: "180px"},
                {field: "Job_No", title: "排单号", width: "100px"},
                {field: "Lot_NO", title: "批次", width: "80px"},
                {field: "payMent", title: "付款方式", width: "100px"},
                {field: "Lot_Type", title: "批次类型", width: "100px"},
                {field: "Lot_Status", title: "批次状态", width: "100px"},
                {field: "Quantity", title: "要求数", width: "100px"},
                {field: "Packed_Qty", title: "装单数", footerTemplate: "#: sum#", width: "100px"},
                {field: "Delivery_Qty", title: "欠数", width: "100px"},
                {field: "Destination", title: "交地", width: "100px"},
                {field: "Delivery_Date", title: "QI交期", format: "{0: yyyy-MM-dd}", width: "100px"},
                {field: "MakeOrderRatio", title: "参考比例", width: "100px"},
                {field: "Over_Ship", title: "溢装比例", width: "100px"},
                {field: "Short_Ship", title: "短装比例", width: "100px"},
                {field: "Print_Prec", title: "所占比例", width: "160px"},
                {field: "IS_Deliveried", title: "是否已出货完", width: "120px"},
                {field: "Combo", title: "颜色", width: "300px"},
                {field: "color_code", title: "色号", width: "300px"},
                {field: "Customer", title: "客户", width: "300px"},
                {field: "PPO_Lot_ID", title: "批次序号", width: "100px"},
            ],
            dataSource: {data: [], aggregate: {field: 'Packed_Qty', aggregate: 'sum'}},
            dataBound: function () {
                var grid = this;

                grid.element.on('dblclick', 'tbody tr[data-uid]', function (e) {
                    kendo.ui.progress($(document.body), true);
                    var selectedRows = grid.select();
                    var dataItem = grid.dataItem(selectedRows[0]);
                    $.ajax({
                        url: getApiUrl() + '/search_pack_detail/' + dataItem.PPO_Lot_ID,
                        method: 'GET',
                        success: function (res) {
                            gekOverShortRatioDetailBottomGrid.setDataSource(new kendo.data.DataSource({
                                data: res
                            }))
                            kendo.ui.progress($(document.body), false);
                        },
                        error: function (err) {
                            kendo.ui.progress($(document.body), false);
                            console.log(err)
                        }

                    })

                })
            }
        }).data('kendoGrid');

        gekOverShortRatioDetailBottomGrid = $("#gekOverShortRatioDetailBottomGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "Batch_NO", title: "缸号", width: "180px"},
                {field: "GK_NO", title: "品名", width: "180px"},
                {field: "Job_NO", title: "排单号", width: "180px"},
                {field: "Fabric_NO", title: "布号", width: "180px"},
                {field: "Circle", title: "循环数", width: "180px"},
                {field: "Grade", title: "等级", width: "180px"},
                {field: "OZYD", title: "码重", width: "180px"},
                {field: "Shade", title: "色级", width: "180px"},
                {field: "Quantity", title: "码长", width: "180px"},
                {field: "Allow_Quantity", title: "送码", width: "180px"},
                {field: "FOC_Quantity", title: "FOC长", width: "180px"},
                {field: "Laste_Quantity", title: "装单码长", width: "180px"},
                {field: "Weight", title: "重量", width: "180px"},
                {field: "Allow_Weight", title: "送码重", width: "180px"},
                {field: "FOC_Weight", title: "FOC重", width: "180px"},
                {field: "Laste_Weight", title: "装单重量", width: "180px"},
                {field: "DN_Type", title: "出货类型", width: "180px"},
                {field: "DN_Department", title: "装单部门", width: "180px"},
                {field: "Status", title: "装单状态", width: "180px"},
                {field: "百平方码分", title: "百平方码分", width: "180px"},
                {field: "让码疵点分", title: "让码疵点分", width: "180px"},
                {field: "主要疵点名", title: "主要疵点名", width: "180px"},
                {field: "总疵点分", title: "总疵点分", width: "180px"},

            ]
        }).data('kendoGrid');

        widthOverGrid = $("#widthOverGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "Batch_NO", title: "缸号", width: "100px"},
                {field: "GK_NO", title: "品名", width: "180px"},
                {field: "JOB_NO", title: "排单号", width: "140px"},
                {field: "PPO_No", title: "订单号", width: "180px"},
                {field: "Fabric_No", title: "布号", width: "140px"},
                {field: "Laste_Quantity", title: "装单码长", width: "120px"},
                {field: "qi_width", title: "实测幅宽", width: "120px"},
                {field: "art_width", title: "工艺幅宽", width: "120px"},
                {field: "scale_range", title: "偏大范围", width: "120px"},
                {field: "qi_repeat", title: "实测循环", width: "120px"},
                {field: "art_repeat", title: "工艺循环", width: "120px"},
                {field: "qi_ozyd", title: "实测码重", width: "120px"},
                {field: "art_ozyd", title: "工艺码重", width: "120px"},
                {field: "Status", title: "状态", width: "80px"},

            ]
        }).data('kendoGrid');

        tdcShrinkageGrid = $("#tdcShrinkageGrid").kendoGrid({
            sortable: true,
            filterable: true,
            selectable: true,
            resizable: true,
            groupable: {messages: {empty: "拖动列名到此处进行分组"}},
            columns: [
                {field: "Batch_No", title: "缸号", width: "120px"},
                {field: "Fabric_No", title: "布号", width: "160px"},
                {field: "Length", title: "长", width: "60px"},
                {field: "Width", title: "宽", width: "60px"},

            ]
        }).data('kendoGrid');

        $('#gekOverShortRatioDetail').on('show.bs.modal', function (e) {
            // for (var i = 0; i < gekOverShortRatioDetailTopGrid.columns.length; i++) {
            //   gekOverShortRatioDetailTopGrid.autoFitColumn(i);
            // }
        })

        $('.collapse').on('shown.bs.collapse', function () {
            $(this).parent().find(".k-i-plus").removeClass("k-i-plus").addClass("k-i-minus");
        }).on('hidden.bs.collapse', function () {
            $(this).parent().find(".k-i-minus").removeClass("k-i-minus").addClass("k-i-plus");
        });
    });

    function getApiUrl() {
        return location.protocol + '//' + location.hostname + (location.port ? ':' + location.port : '') + '/api';
    }

    function search() {
        kendo.ui.progress($(document.body), true);
        $('#gekOverShortRatio').val('');
        $('#gmtOverShortRatio').val('');
        $('#allowQty').val('');
        $('#widthOver').val('');
        $('#tdcShrinkage').val('');
        $('#artShrinkage').val('');
        gekOverShortRatioDetailBottomGrid.setDataSource(new kendo.data.DataSource({
            data: []
        }));

        $.ajax({
            url: getApiUrl() + '/search_gknum_info?gknum=' + $('#gknum').val().trim() + '&jobnum=' + $('#jobnum').val() + '&pponum=' + $('#pponum').val(),
            method: 'GET',
            success: function (res) {
                // GEK实际溢短
                if (res.gekOverShort.length > 0) {
                    var sumPackedQty = res.gekOverShort.reduce(function (acc, cur) {
                        return acc + cur.Packed_Qty
                    }, 0)
                    var sumQuantity = res.gekOverShort.reduce(function (acc, cur) {
                        return acc + cur.Quantity
                    }, 0)
                    var ratio;
                    try {
                        ratio = Math.round((sumPackedQty - sumQuantity) / sumQuantity * 10000) / 100;
                    } catch (error) {
                        console.log('Invalid Params')
                    }
                    $('#gekOverShortRatio').val(ratio + '%');
                }

                // 成衣实际溢短
                if (res.gmtOverShort.length > 0) {
                    $('#gmtOverShortRatio').val(res.gmtOverShort[0].GMT_OVER_SHORT);
                }

                // 让码码数
                $('#allowQty').val(res.allowQty);

                // 装单明细
                gekOverShortRatioDetailTopGrid.setDataSource(new kendo.data.DataSource({
                    data: res.gekOverShort.map(function (item) {
                        item.Delivery_Date && (item.Delivery_Date = new Date(item.Delivery_Date));
                        item.Print_Prec && (item.Print_Prec = Math.round(item.Print_Prec * 100) / 100);
                        return item;
                    }),
                    aggregate: [
                        {field: "Packed_Qty", aggregate: "sum"},
                    ]
                }))

                // 门幅偏大明细
                var widthOverDetail = res.widthOver.filter(function (item) {
                    return item.Batch_NO
                })
                widthOverGrid.setDataSource(new kendo.data.DataSource({
                    data: widthOverDetail
                }))

                // 门幅偏大汇总
                var widthOverRatio = res.widthOver.filter(function (item) {
                    return item.ratio
                })
                if (widthOverRatio.length > 0) {
                    var widthOverResult = widthOverRatio.reduce(function (acc, cur) {
                        return acc + cur.scale_range + ': ' + cur.ratio + '%  '
                    }, '');

                    $('#widthOver').val(widthOverResult);
                }

                // TDC缩水结果
                tdcShrinkageGrid.setDataSource(new kendo.data.DataSource({
                    data: res.tdcShrinkage
                }))
                if (res.tdcShrinkage.length > 0) {
                    var lengths = res.tdcShrinkage.map(function (item) {
                        return item.Length
                    })

                    var widths = res.tdcShrinkage.map(function (item) {
                        return item.Width
                    })

                    var maxLength = Math.max.apply(null, lengths);
                    var maxWidth = Math.max.apply(null, widths);
                    var minLength = Math.min.apply(null, lengths);
                    var minWidth = Math.min.apply(null, widths);

                    $('#tdcShrinkage').val('L: Max ' + maxLength + ', Min ' + minLength + '  W: Max ' + maxWidth + ', Min ' + minWidth);
                    $('#artShrinkage').val(res.tdcShrinkage[0].Shrinkage);
                }

                // 染整
                dyeGrid.setDataSource(new kendo.data.DataSource({
                    data: res.dye.map(function (item) {
                        item['工序时间'] && (item['工序时间'] = new Date(item['工序时间']));
                        item['发布时间'] && (item['发布时间'] = new Date(item['发布时间']));
                        item['备布时间'] && (item['备布时间'] = new Date(item['备布时间']));
                        item['逢边时间'] && (item['逢边时间'] = new Date(item['逢边时间']));
                        item['投染时间'] && (item['投染时间'] = new Date(item['投染时间']));
                        item['内对色时间'] && (item['内对色时间'] = new Date(item['内对色时间']));
                        item['BF时间'] && (item['BF时间'] = new Date(item['BF时间']));
                        item['烘干时间'] && (item['烘干时间'] = new Date(item['烘干时间']));
                        item['中检时间'] && (item['中检时间'] = new Date(item['中检时间']));
                        item['丝光时间'] && (item['丝光时间'] = new Date(item['丝光时间']));
                        item['抓磨毛时间'] && (item['抓磨毛时间'] = new Date(item['抓磨毛时间']));
                        item['预缩时间'] && (item['预缩时间'] = new Date(item['预缩时间']));
                        item['定型时间'] && (item['定型时间'] = new Date(item['定型时间']));
                        item['AF时间'] && (item['AF时间'] = new Date(item['AF时间']));
                        return item;
                    }),
                    // group: { field: '排单号' }
                }));
                dyeQualityGrid.setDataSource(new kendo.data.DataSource({
                    data: res.dyeQuality.map(function (item) {
                        item['工序时间'] && (item['工序时间'] = new Date(item['工序时间']));
                        item['发布时间'] && (item['发布时间'] = new Date(item['发布时间']));
                        item['备布时间'] && (item['备布时间'] = new Date(item['备布时间']));
                        item['逢边时间'] && (item['逢边时间'] = new Date(item['逢边时间']));
                        item['投染时间'] && (item['投染时间'] = new Date(item['投染时间']));
                        item['内对色时间'] && (item['内对色时间'] = new Date(item['内对色时间']));
                        item['BF时间'] && (item['BF时间'] = new Date(item['BF时间']));
                        item['烘干时间'] && (item['烘干时间'] = new Date(item['烘干时间']));
                        item['中检时间'] && (item['中检时间'] = new Date(item['中检时间']));
                        item['丝光时间'] && (item['丝光时间'] = new Date(item['丝光时间']));
                        item['抓磨毛时间'] && (item['抓磨毛时间'] = new Date(item['抓磨毛时间']));
                        item['预缩时间'] && (item['预缩时间'] = new Date(item['预缩时间']));
                        item['定型时间'] && (item['定型时间'] = new Date(item['定型时间']));
                        item['AF时间'] && (item['AF时间'] = new Date(item['AF时间']));
                        return item;
                    }),
                    // group: { field: '排单号' }
                }));

                // QI
                qiGrid.setDataSource(new kendo.data.DataSource({
                    data: res.qi.map(function (item) {
                        item.Delivery_Date && (item.Delivery_Date = new Date(item.Delivery_Date));
                        item.In_Time && (item.In_Time = new Date(item.In_Time));
                        item.QC_Time && (item.QC_Time = new Date(item.QC_Time));
                        item.Inspect_Time && (item.Inspect_Time = new Date(item.Inspect_Time));
                        return item
                    }),
                    page: 1,
                    pageSize: 10
                }));
                qiQualityGrid.setDataSource(new kendo.data.DataSource({
                    data: res.qiQuality.map(function (item) {
                        item.Delivery_Date && (item.Delivery_Date = new Date(item.Delivery_Date));
                        item.In_Time && (item.In_Time = new Date(item.In_Time));
                        item.QC_Time && (item.QC_Time = new Date(item.QC_Time));
                        item.Inspect_Time && (item.Inspect_Time = new Date(item.Inspect_Time));
                        return item
                    }),
                    page: 1,
                    pageSize: 10
                }));

                // 库存
                storeGrid.setDataSource(new kendo.data.DataSource({
                    data: res.store
                }));
                storeQualityGrid.setDataSource(new kendo.data.DataSource({
                    data: res.storeQuality
                }));

                // 装单
                packGrid.setDataSource(new kendo.data.DataSource({
                    data: res.pack.map(function (item) {
                        item.Delivery_Date && (item.Delivery_Date = new Date(item.Delivery_Date));
                        item.Print_Prec && (item.Print_Prec = Math.round(item.Print_Prec * 100) / 100);
                        return item;
                    }),
                }));
                packQualityGrid.setDataSource(new kendo.data.DataSource({
                    data: res.packQuality.map(function (item) {
                        item.Delivery_Date && (item.Delivery_Date = new Date(item.Delivery_Date));
                        item.Print_Prec && (item.Print_Prec = Math.round(item.Print_Prec * 100) / 100);
                        return item;
                    }),
                }));

                kendo.ui.progress($(document.body), false);
            },
            error: function (err) {
                kendo.ui.progress($(document.body), false);
                console.log(err)
            }

        })
    }

    function adjustColumnWidthTotal() {
        kendo.ui.progress($(document.body), true);

        var timeout = setTimeout(function () {


            if (tabstrip.select()[0].textContent === '相同品名') {
                for (var i = 0; i < dyeGrid.columns.length; i++) {
                    dyeGrid.autoFitColumn(i);
                }

                for (var j = 0; j < qiGrid.columns.length; j++) {
                    qiGrid.autoFitColumn(j);
                }

                for (var k = 0; k < storeGrid.columns.length; k++) {
                    storeGrid.autoFitColumn(k);
                }

                for (var l = 0; l < packGrid.columns.length; l++) {
                    packGrid.autoFitColumn(l);
                }
            }

            if (tabstrip.select()[0].textContent === '相同质量') {
                for (var m = 0; m < dyeQualityGrid.columns.length; m++) {
                    dyeQualityGrid.autoFitColumn(m);
                }
                for (var n = 0; n < qiQualityGrid.columns.length; n++) {
                    qiQualityGrid.autoFitColumn(n);
                }
                for (var o = 0; k < storeQualityGrid.columns.length; o++) {
                    storeQualityGrid.autoFitColumn(o);
                }
                for (var p = 0; p < packQualityGrid.columns.length; p++) {
                    packQualityGrid.autoFitColumn(p);
                }
            }


            setTimeout(function () {

                kendo.ui.progress($(document.body), false);
            }, 1);

        }, 1);

    }

    function adjustColumnWidthSingle(grid) {
        kendo.ui.progress($(document.body), true);

        setTimeout(function () {
            for (var i = 0; i < grid.columns.length; i++) {
                grid.autoFitColumn(i);
            }

            setTimeout(function () {
                kendo.ui.progress($(document.body), false);
            }, 1);

        }, 1);
    }

    function getJobnum(value) {
        kendo.ui.progress($(document.body), true);
        jobnum.text('');
        $.ajax({
            url: getApiUrl() + '/search_jobnum?gknum=' + value,
            method: 'GET',
            success: function (res) {
                jobnum.setDataSource(new kendo.data.DataSource({
                    data: res
                }))
                jobnum.select(0);
                jobnum.trigger('change');
                kendo.ui.progress($(document.body), false);
            },
            error: function (err) {
                kendo.ui.progress($(document.body), false);
                console.log(err)
            }

        })

    }
</script>
</body>

</html>