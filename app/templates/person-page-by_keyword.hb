<script type="text/x-handlebars" data-template-name="Nmdb-person-page-by_keyword-dropdown">
foo
  <option value="">Keywords</option>
  {{#each entry in pageData}}
  <option value="{{unbound entry.keyword}}"><h4>{{entry.display}} ({{entry.count}})</h4></option>
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-by_keyword">
  <div class="row">
    <div {{bind-attr class="isMobile::panel isMobile::panel-default"}}>
      {{#unless isMobile}}
      <div class="panel-heading">
	<h4 class="panel-title">Movies by Keyword</h4>
      </div>
      {{/unless}}
      <div class="col-xs-12 visible-xs visible-sm no-padding">
	<h4>{{view Nmdb.PersonPageByKeywordDropdownView}}</h4>
      </div>
      <div class="col-md-3 visible-md visible-lg no-padding">
	<div class="panel-body no-padding-right">
	  <div id="keyword-header" class="list-group">
	    <h4 class="panel-heading">Keywords</h4>
	  {{#each entry in pageData}}
	  <a class="list-group-item" {{action selectEntry entry.keyword}}>{{entry.display}} ({{entry.count}})</a>
	  {{/each}}
	  </div>
	</div>
      </div>
      <div {{bind-attr class=":col-xs-12 :col-md-9 isMobile:no-padding"}}>
      {{#each entry in pageDataSelected}}
      <div {{bind-attr id="entry.keyword" class="isMobile:panel isMobile:panel-default isMobile:margin-bottom-large"}}>
      <div {{bind-attr class=":panel-body isMobile::no-padding-hori isMobile:no-padding"}}>
	<h4 class="panel-heading">{{entry.display}}</h4>
	{{#unless isMobile}}
        <table class="table table-condensed grey-border no-margin-bottom">
          <thead>
            <tr>
	      <th width="1%"></th>
	      <th width="60%">Cast</th>
	      <th width="39%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each movieEntry in entry.movies}}
            <tr>
	      <th>{{index}}</th>
	      <td>
                {{#link-to 'movie' movieEntry.movie.id}}{{displayTitle movieEntry.movie}}{{/link-to}}
	      </td>
	      <td>{{movieEntry.character}} {{movieEntry.extras}}</td>
            </tr>
            {{/each}}
          </tbody>
        </table>
	{{else}}
	<div class="list-group no-margin">
	  {{#each movieEntry in entry.movies}}
	  {{#link-to 'movie' movieEntry.movie.id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
          <h4 class="list-group-item-heading truncate-text">
            {{displayTitle movieEntry.movie}}
          </h4>
          <div class="list-group-item-text indent-left truncate-text">
            {{movieEntry.character}} {{movieEntry.extras}}
          </div>
	  {{/link-to}}
	  {{/each}}
	</div>
	{{/unless}}
      </div>
      </div>
      {{/each}}
	</div>
      <div class="clearfix"></div>
    </div>
  </div>
</script>

