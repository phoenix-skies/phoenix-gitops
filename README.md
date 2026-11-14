# phoenix-gitops

The **desired state** of Project Phoenix. Nothing reaches the cluster except through this repository. Argo CD reconciles it.

```
phoenix-gitops/
├── apps/                    Day 2  plain Kubernetes manifests (frontend, backend, database)
├── environments/            Day 5  Kustomize: base + dev / qa / prod overlays
├── helm/phoenix/            Day 6  Helm chart + values-dev/qa/prod.yaml
│   └── templates/           Rollout + AnalysisTemplate (Day 9), SealedSecret (Day 8), ServiceMonitor (Day 9)
├── applicationsets/         Day 6  ApplicationSet (dev/qa/prod) + monitoring app, managed by the root app
├── argocd/                  Day 3/4/8  AppProject, RBAC, first app, Kustomize apps, root app (App of Apps)
├── monitoring/              Day 9  Grafana dashboard (delivered by GitOps)
└── .github/                 Day 7/8  validate + promote workflows, CODEOWNERS
```

## Two deployment tracks

| Track | Used on | Namespaces | Argo CD apps |
|---|---|---|---|
| Kustomize | Days 3–5 | `phoenix-kz-dev/qa/prod` | `argocd/applications/day3-first-app.yaml`, `argocd/kustomize-apps/*` |
| Helm + ApplicationSet | Day 6 onwards and the capstone | `phoenix-dev/qa/prod` | `argocd/root-app.yaml` → `applicationsets/*` |

They use separate namespaces, so you can compare them side by side.

## Environment policy

| | dev | qa | prod |
|---|---|---|---|
| Updated by | CI PR (automatic) | `promote` workflow PR | `promote` workflow PR |
| Review | any team member | any team member | **CODEOWNERS (release-managers)** |
| Argo CD sync | auto + self-heal + prune | auto + self-heal + prune | **manual** (release manager) |
| Replicas (api) | 1 | 2 | 4 |

## Promote a release

Go to **Actions → promote → Run workflow**, choose `dev → qa` (or `qa → prod`), then review and merge the PR. Argo CD does the rest.
