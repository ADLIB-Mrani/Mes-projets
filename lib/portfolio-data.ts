export type Competence = { code:string; title:string; shortTitle:string; description:string; methods:string[] };
export type Project = {
  slug:string; title:string; summary:string; semester:number|null; origin:"but"|"alternance"|"personnel";
  status:"en_cours"|"termine"; published:boolean; competences:string[]; technologies:string[];
  context:string; contribution:string; result:string; dataSource:string; startedAt:string|null;
  repositoryUrl:string|null; deliverableUrl:string|null;
};
export type Portfolio = { projects:Project[]; competences:Competence[]; formationMinutes:number|null; hoursByCompetence:Record<string,number|null>; validatedAc:number|null; storage:"reference"|"supabase"|"unavailable"; updatedAt:string };
export const COMPETENCES:Competence[] = [
  {code:"C1",shortTitle:"Traiter les données",title:"Traiter des données à des fins décisionnelles",description:"Rendre les données exploitables : comprendre les sources, organiser les informations et contrôler leur qualité avant toute analyse.",methods:["Collecte et préparation","Modélisation des données","Qualité et cohérence"]},
  {code:"C2",shortTitle:"Analyser les données",title:"Analyser statistiquement les données",description:"Explorer les données, choisir des méthodes adaptées et interpréter les résultats en tenant compte de leurs limites.",methods:["Exploration statistique","Choix des méthodes","Interprétation des résultats"]},
  {code:"C3",shortTitle:"Valoriser les résultats",title:"Valoriser une production dans un contexte professionnel",description:"Présenter une démarche et ses résultats dans un format clair, adapté aux personnes qui vont les utiliser.",methods:["Visualisation","Communication des résultats","Documentation et preuves"]},
  {code:"C4",shortTitle:"Créer des outils",title:"Développer un outil décisionnel",description:"Transformer un besoin en un outil utilisable : concevoir, développer, vérifier et améliorer une solution.",methods:["Conception d’interface","Développement","Tests et versionnement"]}
];
export const PORTFOLIO_PROJECT:Project = {
  slug:"portfolio-but-sd",title:"Un portfolio pour raconter trois années de data",summary:"Concevoir un portfolio qui relie les projets, les compétences et les preuves d’un parcours en BUT Science des données.",semester:5,origin:"but",status:"en_cours",published:true,competences:["C1","C3","C4"],technologies:["TypeScript","React","HTML","CSS","PostgreSQL","GitHub"],
  context:"Le projet consiste à construire un portfolio des trois années de BUT Science des données. Il doit présenter les réalisations, les quatre compétences du diplôme, les outils utilisés et l’alternance, dans une interface responsive.",
  contribution:"Structurer les contenus et les données du portfolio, définir une charte graphique, préparer une maquette ordinateur/mobile, organiser les relations PostgreSQL et construire une première application consultable. Le dépôt et le journal conservent les étapes, les décisions et les limites du projet.",
  result:"Une première version du portfolio, avec une navigation par projets et compétences, des filtres et une structure prête à accueillir les réalisations de chaque semestre. Les informations personnelles et les volumes horaires restent à compléter à partir de sources vérifiées.",
  dataSource:"Cahier des charges du module portfolio, documents de conception et fichiers du dépôt Mes-projets. Aucun résultat de projet ni volume horaire des trois années n’est inventé.",
  startedAt:"2026-10-14",repositoryUrl:"https://github.com/ADLIB-Mrani/Mes-projets",deliverableUrl:null
};
export function referencePortfolio():Portfolio { return {projects:[PORTFOLIO_PROJECT],competences:COMPETENCES,formationMinutes:null,hoursByCompetence:{C1:null,C2:null,C3:null,C4:null},validatedAc:null,storage:"reference",updatedAt:"2026-11-23"}; }
export type Filters = {search?:string;year?:string;semester?:string;competence?:string;technology?:string};
const normalize=(s:string)=>s.normalize("NFD").replace(/[\u0300-\u036f]/g,"").toLocaleLowerCase("fr");
export function filterProjects(projects:Project[],f:Filters):Project[] {
  const q=normalize((f.search||"").trim());
  return projects.filter(p=>p.published===true && (!q||normalize([p.title,p.summary,...p.technologies].join(" ")).includes(q)) && (!f.year||(p.semester!==null&&String(Math.ceil(p.semester/2))===f.year)) && (!f.semester||String(p.semester)===f.semester) && (!f.competence||p.competences.includes(f.competence)) && (!f.technology||p.technologies.includes(f.technology)));
}
export function safeExternalHref(value:string|null):string|null {if(!value)return null;try{const url=new URL(value);return ["https:","http:"].includes(url.protocol)?url.href:null;}catch{return null;}}
export function formationHours(minutes:number|null):string {return minutes===null?"À renseigner":new Intl.NumberFormat("fr-FR",{maximumFractionDigits:1}).format(minutes/60)+" h";}
