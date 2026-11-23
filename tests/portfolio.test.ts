import {test} from "node:test";
import assert from "node:assert/strict";
import {filterProjects,formationHours,safeExternalHref,PORTFOLIO_PROJECT,referencePortfolio} from "../lib/portfolio-data.ts";

test("les projets privés restent invisibles même sans filtres",()=>{
 const privateProject={...PORTFOLIO_PROJECT,slug:"projet-prive",published:false};
 assert.deepEqual(filterProjects([privateProject,PORTFOLIO_PROJECT],{}).map(p=>p.slug),["portfolio-but-sd"]);
});
test("la recherche sans accents et les quatre filtres se combinent",()=>{
 const filters={search:"donnees",year:"3",semester:"5",competence:"C1",technology:"React"};
 assert.equal(filterProjects([PORTFOLIO_PROJECT],filters).length,1);
 assert.equal(filterProjects([PORTFOLIO_PROJECT],{...filters,competence:"C2"}).length,0);
 assert.equal(filterProjects([PORTFOLIO_PROJECT],{...filters,year:"1"}).length,0);
});
test("un volume inconnu ne devient jamais zéro heure",()=>{
 assert.equal(formationHours(null),"À renseigner");
 assert.equal(formationHours(150),"2,5 h");
 assert.equal(referencePortfolio().formationMinutes,null);
 assert.equal(referencePortfolio().validatedAc,null);
});
test("les liens externes rejetent les protocoles exécutables",()=>{
 assert.equal(safeExternalHref("javascript:alert(1)"),null);
 assert.equal(safeExternalHref("data:text/html,example"),null);
 assert.equal(safeExternalHref("/projets"),null);
 assert.equal(safeExternalHref("https://github.com/ADLIB-Mrani/Mes-projets"),"https://github.com/ADLIB-Mrani/Mes-projets");
});
