<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-keywords">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Keywords</h4>
      </div>
      <div class="panel-body">
        {{#each model.pageData}}
        <span class="col-xs-6 col-sm-6 col-md-4 col-lg-4 panel">
	  <span {{bind-attr class="strong:bold"}}>{{display}}</span>
	</span>
        {{/each}}
      </div>
    </div>
  </div>
</script>

