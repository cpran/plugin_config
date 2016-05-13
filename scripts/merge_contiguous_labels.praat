include ../../plugin_tgutils/procedures/merge_contiguous_labels.proc

form Merge contiguous labels...
  positive Tier 1 (0 = all)
  comment  Only interval tiers are currently supported
endform

textgrid = Copy: selected$("TextGrid") + "_merged"

if !tier
  total_tiers = Get number of tiers
  for i to total_tiers
    @mergeContiguousLabels: i
  endfor
else
  @mergeContiguousLabels: tier
endif
