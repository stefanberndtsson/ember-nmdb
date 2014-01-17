<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-soundtrack">
  <div class="row">
    <div {{bind-attr class="isMobile::panel isMobile::panel-default"}}>
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Soundtrack</h4>
      </div>
      {{/unless}}
      {{#each entry in model.pageData}}
      <div {{bind-attr class="isMobile:panel isMobile:panel-default isMobile:margin-bottom-large"}}>
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	<ul class="list-group no-margin">
	  <h4 class="panel-heading">{{decodeLinks entry.title entry.links}}</h4>
          <li class="list-group-item">
	    {{#each entry.lines}}
	    <div>{{decodeLinks line links}}</div>
	    {{/each}}
	  </li>
	</ul>
      </div>
      </div>
      {{/each}}
    </div>
  </div>
</script>
