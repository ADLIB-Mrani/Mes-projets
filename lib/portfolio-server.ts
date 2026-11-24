import {COMPETENCES,referencePortfolio,type Portfolio,type Project} from "./portfolio-data";
type RuntimeEnv={SUPABASE_URL?:string;SUPABASE_PUBLISHABLE_KEY?:string};
export async function getPortfolio():Promise<Portfolio> {
  const config:RuntimeEnv={SUPABASE_URL:process.env.SUPABASE_URL,SUPABASE_PUBLISHABLE_KEY:process.env.SUPABASE_PUBLISHABLE_KEY};const fallback=referencePortfolio();
  if(!config.SUPABASE_URL||!config.SUPABASE_PUBLISHABLE_KEY)return fallback;
  try{
    const response=await fetch(new URL("/rest/v1/portfolio_snapshot?select=payload&limit=1",config.SUPABASE_URL),{headers:{apikey:config.SUPABASE_PUBLISHABLE_KEY,Accept:"application/json"},signal:AbortSignal.timeout(8000),cache:"no-store"});
    if(!response.ok)throw new Error("Portfolio data unavailable");
    const rows=await response.json() as {payload:Partial<Portfolio>}[];const payload=rows[0]?.payload;
    if(!payload||!Array.isArray(payload.projects))throw new Error("Invalid portfolio payload");
    const projects=(payload.projects as Project[]).filter(p=>p.published===true&&/^[a-z0-9]+(-[a-z0-9]+)*$/.test(p.slug));
    return {...fallback,...payload,projects,competences:COMPETENCES,storage:"supabase"};
  }catch{return {...fallback,storage:"unavailable"};}
}
