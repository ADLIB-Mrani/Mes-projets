import {getPortfolio} from "@/lib/portfolio-server";
import {ProjectExplorer} from "@/components/project-explorer";
import type {Filters} from "@/lib/portfolio-data";
export const dynamic="force-dynamic";
export const metadata={title:"Projets"};
export default async function Projects({searchParams}:{searchParams:Promise<Record<string,string|string[]|undefined>>}){const data=await getPortfolio();const params=await searchParams;const initial:Filters={};for(const key of["search","year","semester","competence","technology"]as const)if(typeof params[key]==="string")initial[key]=params[key];return <section className="container page-section"><div className="page-heading"><div className="eyebrow">EXPLORER LES RÉALISATIONS</div><h1>Les projets.<br/><span>De l’idée à la mise en pratique.</span></h1><p>Une sélection qui se construit au fil du parcours. Retrouvez les méthodes, les outils et les compétences mobilisées dans chaque réalisation.</p></div><ProjectExplorer projects={data.projects} initial={initial}/></section>}
