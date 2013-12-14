<script type="text/x-handlebars" data-template-name="Nmdb-person">
  <div class="col-xs-12">
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="well well-sm">
	<h3 class="page-header">{{model.person.first_name}}&nbsp;{{model.person.last_name}}</h3>
      </div>
    </div>
    {{outlet}}
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page">
  {{view Nmdb.PersonPageDataView}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/person-role-link">
  {{#if role.disabled}}
  <a class="text-center" href="javascript:void(0);">{{role.display}}</a>
  {{else}}
  {{#link-to 'person-page' person.id 'as_role' role=role.name classNames='text-center'}}{{role.display}}{{/link-to}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-as_role">
  <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <ul class="nav nav-pills">
      {{#each role in roles}}
      {{person-role-link role=role person=model.person currentRole=controller.activeRole}}
      {{/each}}
    </ul>
  </div>
  <div class="container row">&nbsp;</div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">Movies</h4>
    </div>
    <div class="panel-body">
      <div class="container row col-xs-12 col-sm-12">
        <table class="table table-condensed">
          <thead>
            <tr>
              <th width="1%"></th>
              <th width="60%">Cast</th>
              <th width="39%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each entry in pageData}}
            <tr>
              <th>{{index}}</th>
              <td>
                {{#link-to 'movie' entry.id}}{{displayTitle entry.movie}}{{/link-to}}
                {{episodeCount entry}}{{episode-hidden-show-link}}
              </td>
              <td>{{entry.character}} {{entry.extras}}</td>
            </tr>
            {{#each episode in entry.episodes}}
            <tr class="{{#ifIndexGt 5}}{{episode-hidden-class}}{{/ifIndexGt}}">
              <th></th>
              <td>
                {{#link-to 'movie' episode.id}} - {{displayEpisode episode}}{{/link-to}}
              </td>
              <td>{{episode.character}} {{episode.extras}}</td>
            </tr>
            {{/each}}
            {{/each}}
          </tbody>
        </table>
      </div>
    </div>
  </div>
</script>
