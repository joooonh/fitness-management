import { Duration, CssDimValue } from '@fullcalendar/core'
import {
  DateComponent,
  DateProfile,
  EventStore,
  EventUiHash,
  EventInteractionState,
  DateSpan,
  memoize,
  DateRange,
  DayTableModel,
  DateEnv,
  DateMarker,
  NowTimer,
} from '@fullcalendar/core/internal'
import {
  createElement,
  createRef,
  VNode,
} from '@fullcalendar/core/preact'
import { TimeCols } from './TimeCols.js'
import { TimeSlatMeta } from './time-slat-meta.js'
import { TimeColsSlatsCoords } from './TimeColsSlatsCoords.js'
import { DayTimeColsSlicer } from './DayTimeColsSlicer.js'

export interface DayTimeColsProps {
  dateProfile: DateProfile
  dayTableModel: DayTableModel
  axis: boolean
  slotDuration: Duration
  slatMetas: TimeSlatMeta[]
  businessHours: EventStore
  eventStore: EventStore
  eventUiBases: EventUiHash
  dateSelection: DateSpan | null
  eventSelection: string
  eventDrag: EventInteractionState | null
  eventResize: EventInteractionState | null
  tableColGroupNode: VNode
  tableMinWidth: CssDimValue
  clientWidth: number | null
  clientHeight: number | null
  expandRows: boolean
  onScrollTopRequest?: (scrollTop: number) => void
  forPrint: boolean
  onSlatCoords?: (slatCoords: TimeColsSlatsCoords) => void
}

export class DayTimeCols extends DateComponent<DayTimeColsProps> {
  private buildDayRanges = memoize(buildDayRanges)
  private slicer = new DayTimeColsSlicer()
  private timeColsRef = createRef<TimeCols>()

  render() {
    let { props, context } = this
    let { dateProfile, dayTableModel } = props
    let { nowIndicator, nextDayThreshold } = context.options
    let dayRanges = this.buildDayRanges(dayTableModel, dateProfile, context.dateEnv)

    // give it the first row of cells
    // TODO: would move this further down hierarchy, but sliceNowDate needs it
    return (
      <NowTimer unit={nowIndicator ? 'minute' : 'day'}>
        {(nowDate: DateMarker, todayRange: DateRange) => (
          <TimeCols
            ref={this.timeColsRef}
            {...this.slicer.sliceProps(props, dateProfile, null, context, dayRanges)}
            forPrint={props.forPrint}
            axis={props.axis}
            dateProfile={dateProfile}
            slatMetas={props.slatMetas}
            slotDuration={props.slotDuration}
            cells={dayTableModel.cells[0]}
            tableColGroupNode={props.tableColGroupNode}
            tableMinWidth={props.tableMinWidth}
            clientWidth={props.clientWidth}
            clientHeight={props.clientHeight}
            expandRows={props.expandRows}
            nowDate={nowDate}
            nowIndicatorSegs={nowIndicator && this.slicer.sliceNowDate(nowDate, dateProfile, nextDayThreshold, context, dayRanges)}
            todayRange={todayRange}
            onScrollTopRequest={props.onScrollTopRequest}
            onSlatCoords={props.onSlatCoords}
          />
        )}
      </NowTimer>
    )
  }
}

export function buildDayRanges(dayTableModel: DayTableModel, dateProfile: DateProfile, dateEnv: DateEnv): DateRange[] {
  let ranges: DateRange[] = []

  for (let date of dayTableModel.headerDates) {
    ranges.push({
      start: dateEnv.add(date, dateProfile.slotMinTime),
      end: dateEnv.add(date, dateProfile.slotMaxTime),
    })
  }

  return ranges
}
