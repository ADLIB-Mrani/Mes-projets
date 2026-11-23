import {getPortfolio} from "@/lib/portfolio-server";
export const dynamic="force-dynamic";
export async function GET(){const data=await getPortfolio();return Response.json({status:data.storage==="unavailable"?"degraded":"ok",storage:data.storage,projectCount:data.projects.length},{status:data.storage==="unavailable"?503:200,headers:{"Cache-Control":"no-store"}})}
