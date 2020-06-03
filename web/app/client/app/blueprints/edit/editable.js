// app.blueprints.edit.editable = (options) => (a, x) => {
//
//   let path = `/blueprints/${options.router.params.blueprint_id}/${options.division}`;
//   let routes = {};
//
//   routes[`/${options.division}`] = (router) => app.inplaceform({
//     path: path,
//     method: 'PATCH',
//     router: router,
//     object: {
//       blueprint: options.blueprint,
//       division: options.division,
//     },
//     success:  (blueprint,el) => {
//       blueprint_el = el.$('^blueprint')
//       options.router.open('..') // (`/blueprints/${options.router.params.blueprint_id}`)
//       blueprint_el.$state = blueprint
//     },
//     form: f => [
//       f.field({
//         key: 'blueprint',
//         vertical: true,
//         label: false,
//         as: 'one',
//         form: options.form,
//       }),
//       f.field({
//         key: "division",
//         as: 'input/hidden',
//       }),
//     ],
//   });
//   routes['*'] = (router) => a.div( app.report({
//     object: options.blueprint,
//     report: options.report,
//   }), {
//     style: { cursor: 'pointer' },
//     $on: {
//       click: () => router.open(path),
//     }
//   });
//
//   return a.p(options.router.routes(routes));
// }
